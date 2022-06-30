extends Node

var club_power: float
var club_distance: Vector2
var club_name: String
var golfer_ability: int
var golfer_power: int = 1.1
var golfer_control: int
var golfer_stamina: int
var golfer_composure: int
var shots: int = 1
var score: int = 0
var distance: int = 0
var crosshair_pos: Vector2
var power: int
var wind_direction
var wind_strength: int
var debug_ball_state: String = "Ball At Rest"
var debug_speed: float
var slice: int
var powerpippos: Vector2
var slicepippos: Vector2

var wind_dictionary: Dictionary = { 
					"North" : ['N',Vector2(0,-1),0, "res://Assets/Other/Wind Arrow/Wind_Arrow_N.png"],
					"NorthEast" : ['NE',Vector2(1,-1),45, "res://Assets/Other/Wind Arrow/Wind_Arrow_NE.png"],
					"East" : ['E',Vector2(1,0),90, "res://Assets/Other/Wind Arrow/Wind_Arrow_E.png"],
					"SouthEast" : ['SE',Vector2(1,1),135, "res://Assets/Other/Wind Arrow/Wind_Arrow_SE.png"],
					"South" : ['S',Vector2(0,1),180, "res://Assets/Other/Wind Arrow/Wind_Arrow_S.png"],
					"SouthWest" : ['SW',Vector2(-1,1),225, "res://Assets/Other/Wind Arrow/Wind_Arrow_SW.png"],
					"West" : ['W',Vector2(-1,0),270,"res://Assets/Other/Wind Arrow/Wind_Arrow_W.png"],
					"NorthWest" : ['Nw',Vector2(-1,1),315,"res://Assets/Other/Wind Arrow/Wind_Arrow_NW.png"],
}					
var wind_key: Array = ["North", "NorthEast", "East", "SouthEast", "South", "SouthWest", "West", "NorthWest"]

func wind_picker(user_input_windstrength):
	randomize()
	var wind_select = wind_key[rand_range(0,7)]
	print(wind_select)
	wind_direction = wind_dictionary[wind_select]
	print(wind_direction[0])
	print(wind_direction[1])
	print(user_input_windstrength)
	if user_input_windstrength == "Low":
		wind_strength = rand_range(1,3)
	elif user_input_windstrength == "Medium":
		wind_strength = rand_range(4,6)
	elif user_input_windstrength == "High":
		wind_strength = rand_range(7,10)
	elif user_input_windstrength == "Random":
		wind_strength = rand_range(0,10)
	else:
		wind_strength = 0
	print(wind_strength)

#club power stats 2.85 = 180 2.6 = 160 1.9 = 120 1.6 = 100 1.4 = 90 1.25 = 80 1.15 = 70 0.8 = 50 0.6 = 40 0.5 = 30
