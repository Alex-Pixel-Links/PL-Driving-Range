extends TileMap

#LargeTree = 80 * 96
#MediumTree = 48 * 64
#SmallTree = 32 * 48

const BushH = preload("res://Flora/Bush_Horizontal.tscn")

func _ready():

	var HBush = get_used_cells_by_id(0)

	replace_HBush(HBush)

func replace_HBush(tileArr):
	var HBushPos
	for i in range(0, tileArr.size()):
		var newHBush = BushH.instance()
		HBushPos = map_to_world(tileArr[i]) + cell_size
		newHBush.set_position(HBushPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newHBush)
