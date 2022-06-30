extends RigidBody2D


func _ready():
	set_mode(1)
	
func set_position(pos):
	position = Vector2(pos.x, pos.y)
