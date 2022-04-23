extends Area2D

var textures = {"red_car":"res://Assets/Objects/car_red.png",
				"black_car":"res://Assets/Objects/car_black.png",
				"white_car":"res://Assets/Objects/car_white.png"}
				
var type

func _ready():
	pass # Replace with function body.
	#Tween stuff in here
	
func car_init (_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos
	
func car_hit():
	pass
	# Do stuff when the car is hit
