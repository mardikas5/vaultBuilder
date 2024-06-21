extends Node

class_name BuildingPlacer

@export var tile_helper : TileMapController
@export var hover_sprite : Sprite2D
@export var hover_sprite_shadow : Sprite2D

var active_building : Building
var lastPos := Vector2i.ZERO
var move_tween : Tween


func _onready():
	hover_sprite.set_process_input(false)
	hover_sprite.set_process_unhandled_input(false)


func _on_select_building(name : String):
	var building = load("res://buildings/"+ name +".tres")
	print(building.resource_name)
	if building != null:
		_swap_active(building)


func _swap_active(building : Building):
	active_building = building
	if building == null:
		hover_sprite.texture = null
	else:
		hover_sprite.texture = building.texture


func _process(delta):
	var pos = tile_helper.active_global_hover

	hover_sprite.visible = tile_helper.is_occupied(tile_helper.grid_hover)

	if pos != lastPos:
		_move_active(pos)


func _input(event: InputEvent):
	if event.is_action_pressed("mb_left"):
		try_place_current()


func _move_active(pos : Vector2i):
	if move_tween != null:
		move_tween.kill()

	move_tween = get_tree().create_tween()
	var hoverPos := pos as Vector2
	hoverPos += Vector2(0,.1)
	move_tween.tween_property(hover_sprite,"position", hoverPos, .1).set_trans(Tween.TRANS_BOUNCE)
	#hover_sprite.global_position = pos
	#hover_sprite.global_position = pos
	lastPos = pos


func try_place_current():
	if tile_helper.hoveredTile != null:
		_place_current()


func _place_current():
	var newBuild := Sprite2D.new()
	newBuild.texture = active_building.texture

	var hoverPos := lastPos as Vector2

	newBuild.global_position = hoverPos + Vector2(0, -32)

	var placeTween = get_tree().create_tween()
	placeTween.tween_property(newBuild, "position", hoverPos, .45).set_trans(Tween.TRANS_BACK)
	
	add_child(newBuild)
	tile_helper.set_occupied(tile_helper.grid_hover)