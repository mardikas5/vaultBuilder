extends Node2D

class_name TileMapController

@export var tilemap : TileMap
@export var hoverSprite : Sprite2D

#var hoveredTile : Vector2i

func _process(delta):
	var newHover = tilemap.local_to_map(get_global_mouse_position())
	hoverSprite.global_position = tilemap.map_to_local(newHover)
	var celldata = tilemap.get_cell_tile_data(1, newHover)
	if celldata:
		hoverSprite.modulate = Color.WHITE;
	else:
		hoverSprite.modulate = Color.BLACK;

	
    