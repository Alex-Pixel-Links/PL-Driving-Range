extends TileMap

#LargeTree = 80 * 96
#MediumTree = 48 * 64
#SmallTree = 32 * 48

const TreeMedium = preload("res://Flora/Tree_Medium.tscn")

func _ready():
	var MediumTree = get_used_cells_by_id(0)

	replace_MediumTree(MediumTree)
		
func replace_MediumTree(tileArr):
	var MediumTreePos
	for i in range(0, tileArr.size()):
		var newMediumTree = TreeMedium.instance()
		MediumTreePos = map_to_world(tileArr[i]) + cell_size
		newMediumTree.set_position(MediumTreePos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newMediumTree)
