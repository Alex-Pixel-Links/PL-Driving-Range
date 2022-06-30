extends TileMap

const TelephoneBox = preload("res://Objects/Telephone_Box.tscn")

func _ready():
	var telephone = get_used_cells_by_id(0)
	
	replaceTelephoneBox(telephone)


func replaceTelephoneBox(tileArr):
	var telePos
	for i in range(0, tileArr.size()):
		var newTelephoneBox = TelephoneBox.instance()
		telePos = map_to_world(tileArr[i]) + cell_size
		newTelephoneBox.set_position(telePos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newTelephoneBox)
