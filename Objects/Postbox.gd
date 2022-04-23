extends StaticBody2D
var textures = {"red_postbox":"res://Assets/Objects/postbox_red.png",
				"green_postbox":"res://Assets/Objects/postbox_green.png",
				"gold_postbox":"res://Assets/Objects/postbox_gold.png"}
				
var type

func _ready():
	pass # Replace with function body.
	#Tween stuff in here
	
func postbox_init (_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos
	
func postbox_hit():
	pass
	# Do stuff when the postbox is hit


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
