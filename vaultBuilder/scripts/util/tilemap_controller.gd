extends Node2D

class_name TileMapController

@export var tilemap : TileMap
@export var hoverSprite : Sprite2D

var active_global_hover : Vector2i
var grid_hover : Vector2i

var hoveredTile : TileData

func _onready():
	hoverSprite.set_process_input(false)
	hoverSprite.set_process_unhandled_input(false)


func _process(delta):
	grid_hover = tilemap.local_to_map(get_global_mouse_position())
	active_global_hover = tilemap.map_to_local(grid_hover)
	hoverSprite.global_position = active_global_hover
	hoveredTile = tilemap.get_cell_tile_data(1, grid_hover)

	if is_occupied(grid_hover):
		hoverSprite.modulate = Color.WHITE;
	else:
		hoverSprite.modulate = Color.BLACK;

	
func set_occupied(pos : Vector2i):
	tilemap.set_cell(1, pos, -1, Vector2i(-1,-1), -1)

func is_occupied(pos : Vector2i) -> bool:
	return tilemap.get_cell_tile_data(1, pos) != null
