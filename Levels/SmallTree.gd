extends TileMap

#LargeTree = 80 * 96
#MediumTree = 48 * 64
#SmallTree = 32 * 48

const TreeSmall = preload("res://Flora/Tree_Small.tscn")

func _ready():
	var SmallTree = get_used_cells_by_id(0)

	replace_SmallTree(SmallTree)
	

func replace_SmallTree(tileArr):
	var SmallTreePos
	for i in range(0, tileArr.size()):
		var newSmallTree = TreeSmall.instance()
		SmallTreePos = map_to_world(tileArr[i]) + cell_size
		newSmallTree.set_position(SmallTreePos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newSmallTree)
