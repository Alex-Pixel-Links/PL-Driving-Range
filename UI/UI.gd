extends CanvasLayer

#Simple code that takes the value passed from Main.gd and updates the powerbar for that value.
func update_powerbar(value):
	$VBoxContainer/TexturePowerBar.value = value


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShotLabelHeader/ShotLabel.text = str(Global.shots)
	$MarginContainer/Distance.text = str(Global.distance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

