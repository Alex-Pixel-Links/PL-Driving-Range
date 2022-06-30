extends TileMap

const Rough = preload("res://Terrain/Rough/HeavyRough/HeavyRough_0.tscn")

func _ready():
	var HeavyRough = get_used_cells_by_id(0)
	
	replace_Rough(HeavyRough)
		
func replace_Rough(tileArr):
	var RoughPos
	for i in range(0, tileArr.size()):
		var newRough = Rough.instance()
		RoughPos = map_to_world(tileArr[i]) + cell_size / 2
		newRough.set_position(RoughPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newRough)
