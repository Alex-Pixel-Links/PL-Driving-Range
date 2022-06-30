extends TileMap

const water_0 = preload("res://Terrain/Water/Water_0.tscn")
const water_1 = preload("res://Terrain/Water/Water_1.tscn")
const water_2 = preload("res://Terrain/Water/Water_2.tscn")
const water_3 = preload("res://Terrain/Water/Water_3.tscn")
const water_4 = preload("res://Terrain/Water/Water_4.tscn")
const water_5 = preload("res://Terrain/Water/Water_5.tscn")
const water_6 = preload("res://Terrain/Water/Water_6.tscn")
const water_7 = preload("res://Terrain/Water/Water_7.tscn")
const water_8 = preload("res://Terrain/Water/Water_8.tscn")

func _ready():
	var water0 = get_used_cells_by_id(0)
	var water1 = get_used_cells_by_id(1)
	var water2 = get_used_cells_by_id(2)
	var water3 = get_used_cells_by_id(3)
	var water4 = get_used_cells_by_id(4)
	var water5 = get_used_cells_by_id(5)
	var water6 = get_used_cells_by_id(6)
	var water7 = get_used_cells_by_id(7)
	var water8 = get_used_cells_by_id(8)
	
	replace_water0(water0)
	replace_water1(water1)
	replace_water2(water2)
	replace_water3(water3)
	replace_water4(water4)
	replace_water5(water5)
	replace_water6(water6)
	replace_water7(water7)
	replace_water8(water8)
	
func replace_water0(tileArr):
	var Water0Pos
	for i in range(0, tileArr.size()):
		var newWater0 = water_0.instance()
		Water0Pos = map_to_world(tileArr[i]) + cell_size / 2
		newWater0.set_position(Water0Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater0)

func replace_water1(tileArr):
	var Water1Pos
	for i in range(0, tileArr.size()):
		var newWater1 = water_1.instance()
		Water1Pos = map_to_world(tileArr[i]) + cell_size / 2
		newWater1.set_position(Water1Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater1)	

func replace_water2(tileArr):
	var Water2Pos
	for i in range(0, tileArr.size()):
		var newWater2 = water_2.instance() 
		Water2Pos = map_to_world(tileArr[i]) + cell_size / 2
		newWater2.set_position(Water2Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater2)

func replace_water3(tileArr):
	var Water3Pos
	for i in range(0, tileArr.size()):
		var newWater3 = water_3.instance()
		Water3Pos = map_to_world(tileArr[i]) + cell_size / 2
		newWater3.set_position(Water3Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater3)

func replace_water4(tileArr):
	var Water4Pos
	for i in range(0, tileArr.size()):
		var newWater4 = water_4.instance()
		Water4Pos = map_to_world(tileArr[i]) + cell_size / 2
		newWater4.set_position(Water4Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater4)

func replace_water5(tileArr):
	var Water5Pos
	for i in range(0, tileArr.size()):
		var newWater5 = water_5.instance()
		Water5Pos = map_to_world(tileArr[i]) + cell_size / 2
		newWater5.set_position(Water5Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater5)

func replace_water6(tileArr):
	var Water6Pos
	for i in range(0, tileArr.size()):
		var newWater6 = water_6.instance()
		Water6Pos = map_to_world(tileArr[i]) + cell_size / 2
		newWater6.set_position(Water6Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater6)

func replace_water7(tileArr):
	var Water7Pos
	for i in range(0, tileArr.size()):
		var newWater7 = water_7.instance()
		Water7Pos = map_to_world(tileArr[i])  + cell_size / 2
		newWater7.set_position(Water7Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater7)

func replace_water8(tileArr):
	var Water8Pos
	for i in range(0, tileArr.size()):
		var newWater8 = water_8.instance()
		Water8Pos = map_to_world(tileArr[i])  + cell_size / 2
		newWater8.set_position(Water8Pos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newWater8)
	
	
