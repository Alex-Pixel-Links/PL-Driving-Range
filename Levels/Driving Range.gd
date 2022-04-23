extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Telephone_Box/Point_Sprite_5.hide()
	$Telephone_Box/Point_Sprite_5/Tween.interpolate_property($Telephone_Box/Point_Sprite_5, 'scale', $Telephone_Box/Point_Sprite_5.scale,
								$Telephone_Box/Point_Sprite_5.scale * 3, 1, Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)
	$Telephone_Box/Point_Sprite_5/Tween.interpolate_property($Telephone_Box/Point_Sprite_5, 'modulate', Color(1, 1, 1, 1),
								Color(1, 1, 1, 0), 1, Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)
								


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
