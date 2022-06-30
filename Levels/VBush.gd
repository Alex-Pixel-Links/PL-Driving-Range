extends TileMap

#LargeTree = 80 * 96
#MediumTree = 48 * 64
#SmallTree = 32 * 48

const BushV = preload("res://Flora/Bush_Vertical.tscn")

func _ready():

	var VBush = get_used_cells_by_id(0)

	replace_VBush(VBush)
	

func replace_VBush(tileArr):
	var VBushPos
	for i in range(0, tileArr.size()):
		var newVBush = BushV.instance()
		VBushPos = map_to_world(tileArr[i]) + cell_size
		newVBush.set_position(VBushPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newVBush)

