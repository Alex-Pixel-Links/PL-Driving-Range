extends Node

var current_club = 0
var bag: Dictionary = {
					"club_driver" : ['Driver',2.85,1800],
					"club_threewood" : ['3 Wood',2.6,1600],
					"club_threeiron" : ['3 Iron',1.9,1200],
					"club_fouriron" : ['4 Iron',1.6,1000],
					"club_fiveiron" : ['5 Iron',1.4,900],
					"club_sixiron" : ['6 Iron',1.25,800],
					"club_seveniron" : ['7 Iron',1.15,700],
					"club_eightiron" : ['8 Iron',0.8,500],
					"club_nineiron" : ['9 Iron',0.6,400],
					"club_pitchingwedge" : ['Pitching Wedge', 0.5,300]
}
var club_selection: Array = ["club_driver", "club_threewood", "club_threeiron", "club_fouriron", "club_fiveiron",
							"club_sixiron", "club_seveniron", "club_eightiron", "club_nineiron", "club_pitchingwedge"]
func _process(_delta):
	#if Input.is_action_pressed("inventory"):
	open_bag()

func open_bag():
	if Input.is_action_just_pressed("ui_up"): 
			current_club -= 1
	if Input.is_action_just_pressed("ui_down"): 
			current_club += 1
	if current_club > bag.size() - 1:  
			current_club = 0
	if current_club < 0: 
			current_club = bag.size() - 1
	var club_key = club_selection[current_club]
	var club_select = bag[club_key]
	Global.club_power = club_select[1]
	Global.club_distance = Vector2(0,club_select[2] * -1)
	Global.club_name = club_select[0]
