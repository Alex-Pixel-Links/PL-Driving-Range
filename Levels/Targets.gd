extends TileMap

const target_large = preload("res://Targets/large_target.tscn")

func _ready():
	var largetarget = get_used_cells_by_id(0)
	var mediumtarget = get_used_cells_by_id(1)
	var smalltarget = get_used_cells_by_id(2)
	
	replace_largetarget(largetarget)
	
func replace_largetarget(tileArr):
	var LargeTargetPos
	for i in range(0, tileArr.size()):
		var newLargeTarget = target_large.instance()
		LargeTargetPos = map_to_world(tileArr[i]) + cell_size * 3
		newLargeTarget.set_position(LargeTargetPos)
		set_cell(tileArr[i].x,tileArr[i].y,-1)
		self.add_child(newLargeTarget)
	
