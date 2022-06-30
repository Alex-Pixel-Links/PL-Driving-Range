extends TileMap

#LargeTree = 80 * 96
#MediumTree = 48 * 64
#SmallTree = 32 * 48

const TreeLarge = preload("res://Flora/Tree_Large.tscn")

func _ready():
	var LargeTree = get_used_cells_by_id(0)
	
	replace_LargeTree(LargeTree)
	
func replace_LargeTree(tileArr):
	var LargeTreePos
	for i in range(0, tileArr.size()):
		var newLargeTree = TreeLarge.instance()
		LargeTreePos = map_to_world(tileArr[i]) + cell_size
		newLargeTree.set_position(LargeTreePos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newLargeTree)
