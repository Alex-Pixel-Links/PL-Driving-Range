extends TileMap

#LargeTree = 80 * 96
#MediumTree = 48 * 64
#SmallTree = 32 * 48

const BushLarge = preload("res://Flora/Bush_Large.tscn")

func _ready():
	var LargeBush = get_used_cells_by_id(0)
	
	replace_LargeBush(LargeBush)
		
func replace_LargeBush(tileArr):
	var LargeBushPos
	for i in range(0, tileArr.size()):
		var newLargeBush = BushLarge.instance()
		LargeBushPos = map_to_world(tileArr[i]) + cell_size
		newLargeBush.set_position(LargeBushPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newLargeBush)
