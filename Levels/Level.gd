extends Node2D

export (PackedScene) var Telephone_box
export (PackedScene) var Postbox
export (PackedScene) var car

#onready var $Objects

#func spawn_items():
#	for cell in objects.get_used_cells():
#		var id = objects.get_cellv(cell)
#		var type = items.tile_set.tile_get_name(id)
#		var pos = items.map_to_world(cell) + items.cell_size/2
#		match type:
#			pass
