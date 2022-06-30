extends TileMap

const CarRed = preload("res://Objects/Car_Red.tscn")
const CarBlack = preload("res://Objects/Car_Black.tscn")
const CarWhite = preload("res://Objects/Car_White.tscn")

func _ready():
	var WhiteCar = get_used_cells_by_id(4)
	var RedCar = get_used_cells_by_id(5)
	var BlackCar = get_used_cells_by_id(6)

	
	replaceWhiteCar(WhiteCar)
	replaceRedCar(RedCar)
	replaceBlackCar(BlackCar)

func replaceWhiteCar(tileArr):
	var WhiteCarPos
	for i in range(0, tileArr.size()):
		var newWhiteCar = CarWhite.instance()
		WhiteCarPos = map_to_world(tileArr[i]) + cell_size
		newWhiteCar.set_position(WhiteCarPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWhiteCar)
		
func replaceRedCar(tileArr):
	var RedCarPos
	for i in range(0, tileArr.size()):
		var newRedCar = CarRed.instance()
		RedCarPos = map_to_world(tileArr[i]) + cell_size
		newRedCar.set_position(RedCarPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newRedCar)
	
func replaceBlackCar(tileArr):
	var BlackCarPos
	for i in range(0, tileArr.size()):
		var newBlackCar = CarBlack.instance()
		BlackCarPos = map_to_world(tileArr[i]) + cell_size
		newBlackCar.set_position(BlackCarPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBlackCar)
