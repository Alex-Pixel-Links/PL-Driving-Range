extends TileMap

const GreenPostBox = preload("res://Objects/Postbox_Green.tscn")
const RedPostBox = preload("res://Objects/Postbox_Red.tscn")
const GoldPostBox = preload("res://Objects/Postbox_Gold.tscn")

func _ready():
	var greenpostbox = get_used_cells_by_id(1)
	var goldpostbox = get_used_cells_by_id(2)
	var redpostbox = get_used_cells_by_id(3)

	replaceGreenPostBox(greenpostbox)
	replaceGoldPostBox(goldpostbox)
	replaceRedPostBox(redpostbox)
		
func replaceGreenPostBox(tileArr):
	var boxPos
	for i in range(0, tileArr.size()):
		var newPostBox = GreenPostBox.instance()
		boxPos = map_to_world(tileArr[i]) + cell_size
		print(boxPos)
		newPostBox.set_position(boxPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newPostBox)	
	
func replaceRedPostBox(tileArr):
	var boxPos
	for i in range(0, tileArr.size()):
		var newPostBox = RedPostBox.instance()
		boxPos = map_to_world(tileArr[i])  + cell_size
		print(boxPos)
		newPostBox.set_position(boxPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newPostBox)	
	
func replaceGoldPostBox(tileArr):
	var boxPos
	for i in range(0, tileArr.size()):
		var newPostBox = GoldPostBox.instance()
		boxPos = map_to_world(tileArr[i]) + cell_size
		print(boxPos)
		newPostBox.set_position(boxPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newPostBox)	
