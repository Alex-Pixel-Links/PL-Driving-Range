extends Node

#Main Node is the node that everything runs from. So the bulk of the functinoal code is written here. We have
#a seperate scene for each action (User Interface, Golf Ball, Level (Driving Range), scoring etc... If there is an action
#that affects the overall game it should be written here and then variables passed to the individual nodes. All subnodes are
#instanced into the main node.

#Things to implement: Wind, Club Selection, Ball Flight and Bounce, Different terrains, Targets, Scoring, Animation,
# Skill Selection, Shot Counting, Ball Flight, Slice, Audio

var power: int = 0
var power_change: int = 1 # 1 moves the power bar in a positive direction, -1 in a negative direciton
var power_speed: int = 100 # speed of the power bar. This variable will be where we use one of the Skills (composure??)
var state: int
var ball_state: int
var crosshair_pos: Vector2 #need new name for this variable
var ball_stopped: bool = false
export var handedness: String
#var club_selection Club selection should be referenced from the global variable list
enum {START, SET_AIM, SET_POWER, SHOOT}

#Moves the power bar up and down automatically. Farily self explanatory
func animate_power_bar(delta):
	power += power_change * power_speed * delta
	if power >= 100:
		power_change = -1
	if power <= 0:
		power_change = 1
	$UI.update_powerbar(power) #sends the power value to the UI node and the update_powerbar function
	Global.power = power

func aiming(delta): # Move to Player.gd???
	if Input.is_action_pressed("ui_left"):
		$Player/FakePlayer.rotation -= 0.5 * delta
		$GolfBall.rotation -= 0.5 * delta
	if Input.is_action_pressed("ui_right"):
		$Player/FakePlayer.rotation += 0.5 * delta
		$GolfBall.rotation += 0.5 * delta
	Global.crosshair_pos = $Player/FakePlayer.global_position - $Player/FakePlayer/Crosshair.global_position
	print(Global.crosshair_pos)
		
func _ready():
	change_state(START) #called at the beginnging to set the state
	$Player/FakePlayer.hide() #Hide Crosshair
	$UI/VBoxContainer/TexturePowerBar.hide() # Hide Power Bar
	$UI/MarginContainer/Distance.hide()
	$UI/MarginContainer2/Spacebar_Continue.hide()
	$UI/ShotLabelHeader/ShotLabel.text = str(Global.shots)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		START:
			pass
		SET_AIM:
			aiming(delta)
		SET_POWER:
			animate_power_bar(delta)
		SHOOT:
			var ball_distance = $GolfBall.global_position - $Player/FakePlayer.global_position
			Global.distance = ball_distance.length()
			$UI/MarginContainer/Distance.text = str("You hit the ball", (Global.distance/10), " yds")
			print(power)
func change_state(new_state):
	state = new_state
	match state:
		START:
			$GolfBall.linear_damp = -1 #Resets Linear Damp
			$GolfBall.linear_velocity = Vector2() #Makes sure the ball is stationary
			$GolfBall.position = Vector2(0,0) #Sets Golfball position			
			$Player/FakePlayer.global_position = $GolfBall.global_position #Sets the position of the fake player
			Global.crosshair_pos = $Player/FakePlayer.global_position - $Player/FakePlayer/Crosshair.global_position # Gets Vector 2 between the crosshair and the GolfBall
			$UI/MarginContainer/Distance.hide()
			$UI/MarginContainer2/Spacebar_Continue.hide()
			$UI/ShotLabelHeader/ShotLabel.text = str(Global.shots)
			$GolfBall/GolfballCamera.make_current()
			if handedness == "right":
				$Player/AnimatedSprite.animation = "swing_right"
				$Player/AnimatedSprite.stop()
				$Player/AnimatedSprite.frame = 0
			else:
				$Player/AnimatedSprite.animation = "swing_left"
				$Player/AnimatedSprite.stop()
				$Player/AnimatedSprite.frame = 0
		SET_AIM:
			$Player/FakePlayer/Crosshair/CrosshairCamera.make_current()
			$Player/FakePlayer.show() #Reveals Crosshair
			$Player/FakePlayer/Crosshair.position = Vector2(0,-1800)
		SET_POWER:
			power = 0
			$GolfBall/GolfballCamera.make_current()
			$UI/VBoxContainer/TexturePowerBar.show() #Reveals Powerbar
		SHOOT:
			$Player/FakePlayer.hide() #Hide Crosshair
			$UI/VBoxContainer/TexturePowerBar.hide() # Hide Power Bar
			if handedness == "right":
				$Player/AnimatedSprite.animation = "swing_right"
				$Player/AnimatedSprite.play()
				yield($Player/AnimatedSprite,"animation_finished")
				$Player/AnimatedSprite.animation = "follow_through_right"
			else:
				$Player/AnimatedSprite.animation = "swing_left"
				$Player/AnimatedSprite.play()
				yield($Player/AnimatedSprite,"animation_finished")
				$Player/AnimatedSprite.animation = "follow_through_left"
			$GolfBall.golfball_hit(power) #passes the Power value determined when the space bar is pressed to the Golfball Node.
#This function controls when we move to the next state.
func _input(event):
	if Input.is_action_pressed("ui_cancel"): #press escape at anytime to reset. It currently breaks stuff.
		change_state(START)
	match state:
		START:
			if Input.is_action_pressed("go_to_aiming"):
				change_state(SET_AIM)
			if Input.is_action_pressed("ui_accept"):
				change_state(SET_POWER)
		SET_AIM:
			if Input.is_action_pressed("go_to_aiming"):
				change_state(START)
			if Input.is_action_pressed("ui_accept"):
				change_state(SET_POWER)
		SET_POWER:
			if Input.is_action_pressed("ui_accept"):
				change_state(SHOOT)
		SHOOT:
			if ball_stopped == true && Input.is_action_pressed("go_to_start"):
				change_state(START)

func end_of_shot():
	ball_stopped = true #set's this value to true to allow the show_result screen to function normally
	if Global.shots < 5:
		Global.shots += 1
	else:
		Global.shots = 0
	show_result()

func stop_all_timers():
	$GolfBall/Timers/StoppedTimer.stop() #Stops All Timers
	$GolfBall/Timers/FallingTimer.stop()
	$GolfBall/Timers/RisingTimer.stop()
	
func _on_GolfBall_telephone_box_hit(value): #increases the value if a Telephone box is hit (may need tweaked)
	Global.score += value
	print(Global.score)
	ball_stopped = true
	stop_all_timers()
#	$"Driving Range/Telephone_Box/Point_Sprite_5".show()
#	$"Driving Range/Telephone_Box/Point_Sprite_5/Tween".start()  removed until I can fix the tween
	end_of_shot()
	
func show_result():
	$UI/MarginContainer/Distance.show() #shows the distance the ball has travelled
	$UI/MarginContainer2/Spacebar_Continue.show()
	
func reset():
	$GolfBall.linear_velocity = Vector2()
	
