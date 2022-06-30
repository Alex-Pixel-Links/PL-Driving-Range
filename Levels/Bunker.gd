extends TileMap

const Bunker_0 = preload("res://Terrain/Bunker/Bunker_0.tscn")
const Bunker_1 = preload("res://Terrain/Bunker/Bunker_1.tscn")
const Bunker_2 = preload("res://Terrain/Bunker/Bunker_2.tscn")
const Bunker_3 = preload("res://Terrain/Bunker/Bunker_3.tscn")
const Bunker_4 = preload("res://Terrain/Bunker/Bunker_4.tscn")
const Bunker_5 = preload("res://Terrain/Bunker/Bunker_5.tscn")
const Bunker_6 = preload("res://Terrain/Bunker/Bunker_6.tscn")
const Bunker_7 = preload("res://Terrain/Bunker/Bunker_7.tscn")
const Bunker_8 = preload("res://Terrain/Bunker/Bunker_8.tscn")

func _ready():
	var Bunker0 = get_used_cells_by_id(0)
	var Bunker1 = get_used_cells_by_id(1)
	var Bunker2 = get_used_cells_by_id(2)
	var Bunker3 = get_used_cells_by_id(3)
	var Bunker4 = get_used_cells_by_id(4)
	var Bunker5 = get_used_cells_by_id(5)
	var Bunker6 = get_used_cells_by_id(6)
	var Bunker7 = get_used_cells_by_id(7)
	var Bunker8 = get_used_cells_by_id(8)
	
	replace_Bunker0(Bunker0)
	replace_Bunker1(Bunker1)
	replace_Bunker2(Bunker2)
	replace_Bunker3(Bunker3)
	replace_Bunker4(Bunker4)
	replace_Bunker5(Bunker5)
	replace_Bunker6(Bunker6)
	replace_Bunker7(Bunker7)
	replace_Bunker8(Bunker8)
	
func replace_Bunker0(tileArr):
	var Bunker0Pos
	for i in range(0, tileArr.size()):
		var newBunker0 = Bunker_0.instance()
		Bunker0Pos = map_to_world(tileArr[i]) + cell_size / 2
		newBunker0.set_position(Bunker0Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker0)

func replace_Bunker1(tileArr):
	var Bunker1Pos
	for i in range(0, tileArr.size()):
		var newBunker1 = Bunker_1.instance()
		Bunker1Pos = map_to_world(tileArr[i]) + cell_size / 2
		newBunker1.set_position(Bunker1Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker1)	

func replace_Bunker2(tileArr):
	var Bunker2Pos
	for i in range(0, tileArr.size()):
		var newBunker2 = Bunker_2.instance() 
		Bunker2Pos = map_to_world(tileArr[i]) + cell_size / 2
		newBunker2.set_position(Bunker2Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker2)

func replace_Bunker3(tileArr):
	var Bunker3Pos
	for i in range(0, tileArr.size()):
		var newBunker3 = Bunker_3.instance()
		Bunker3Pos = map_to_world(tileArr[i]) + cell_size / 2
		newBunker3.set_position(Bunker3Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker3)

func replace_Bunker4(tileArr):
	var Bunker4Pos
	for i in range(0, tileArr.size()):
		var newBunker4 = Bunker_4.instance()
		Bunker4Pos = map_to_world(tileArr[i]) + cell_size / 2
		newBunker4.set_position(Bunker4Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker4)

func replace_Bunker5(tileArr):
	var Bunker5Pos
	for i in range(0, tileArr.size()):
		var newBunker5 = Bunker_5.instance()
		Bunker5Pos = map_to_world(tileArr[i]) + cell_size / 2
		newBunker5.set_position(Bunker5Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker5)

func replace_Bunker6(tileArr):
	var Bunker6Pos
	for i in range(0, tileArr.size()):
		var newBunker6 = Bunker_6.instance()
		Bunker6Pos = map_to_world(tileArr[i]) + cell_size / 2
		newBunker6.set_position(Bunker6Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker6)

func replace_Bunker7(tileArr):
	var Bunker7Pos
	for i in range(0, tileArr.size()):
		var newBunker7 = Bunker_7.instance()
		Bunker7Pos = map_to_world(tileArr[i])  + cell_size / 2
		newBunker7.set_position(Bunker7Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker7)

func replace_Bunker8(tileArr):
	var Bunker8Pos
	for i in range(0, tileArr.size()):
		var newBunker8 = Bunker_8.instance()
		Bunker8Pos = map_to_world(tileArr[i])  + cell_size / 2
		newBunker8.set_position(Bunker8Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBunker8)
	
	
