extends Node

#Main Node is the node that everything runs from. So the bulk of the functinoal code is written here. We have
#a seperate scene for each action (User Interface, Golf Ball, Level (Driving Range), scoring etc... If there is an action
#that affects the overall game it should be written here and then variables passed to the individual nodes. All subnodes are
#instanced into the main node.

#Things to implement: Wind, Club Selection, Ball Flight and Bounce, Different terrains, Targets, Scoring, Animation,
# Skill Selection, Shot Counting, Ball Flight, Slice, Audio

var power: float = 0
var power_change: int = 1 # 1 moves the power bar in a positive direction, -1 in a negative direciton
var power_speed: int = 100 # speed of the power bar. This variable will be where we use one of the Skills (composure??)
var state: int
var ball_state: int
var crosshair_pos: Vector2 #need new name for this variable
var ball_stopped: bool = false
var slice: float = 0
export var handedness: String
export var input_wind_strength: String
#var club_selection Club selection should be referenced from the global variable list
enum {START, SET_AIM, SET_POWER, SET_SLICE, SHOOT}


#Moves the power bar up and down automatically. Farily self explanatory
func animate_power_bar(delta):
	power += power_change * power_speed * delta
	$UI/PowerBarContainer/TexturePowerBar/PowerPip.position.y -= (power_change * power_speed * delta) * 1.9
	if power >= 100:
		power_change = -1
	if power <= 0:
		power_change = 1
	$UI.update_powerbar(power) #sends the power value to the UI node and the update_powerbar function
	Global.power = power

func animate_slice_bar(delta): # why does the power bar move faster in one direction?
	slice += power_change * power_speed * delta
	$UI/SliceContainer/Slice/SlicePip.position.x += (power_change * power_speed * delta) * 0.95
	if slice >= 100:
		power_change = -1
	if slice <= -100:
		power_change = 1
	$UI.update_slicebar(slice) #sends the slice value to the UI node and the update_powerbar function
	Global.slice = slice

func aiming(delta): # Move to Player.gd???
	if Input.is_action_pressed("ui_left"):
		$Player/FakePlayer.rotation -= 0.5 * delta
		$GolfBall.rotation -= 0.5 * delta
	if Input.is_action_pressed("ui_right"):
		$Player/FakePlayer.rotation += 0.5 * delta
		$GolfBall.rotation += 0.5 * delta
	Global.crosshair_pos = $Player/FakePlayer.global_position - $Player/FakePlayer/Crosshair.global_position
		
func _ready():
	change_state(START) #called at the beginnging to set the state
	$Player/FakePlayer.hide() #Hide Crosshair
	$UI/PowerBarContainer/TexturePowerBar.hide() # Hide Power Bar
	$UI/SliceContainer/Slice.hide()
	$UI/MarginContainer/Distance.hide()
	$UI/MarginContainer2/Spacebar_Continue.hide()
	$UI/ShotLabelHeader/ShotLabel.text = str(Global.shots)
	Global.powerpippos = $UI/PowerBarContainer/TexturePowerBar/PowerPip.position
	Global.slicepippos = $UI/SliceContainer/Slice/SlicePip.position
	$UI/ScoreHeader/Score.text = str(Global.score)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		START:
			pass
		SET_AIM:
			aiming(delta)
			$Player/FakePlayer/Crosshair.position = Global.club_distance
		SET_POWER:
			animate_power_bar(delta)
		SET_SLICE:
			animate_slice_bar(delta)		
		SHOOT:
			pass
#	$UI/DebugConsole/DebugConsole.text = str("Ball State: ", Global.debug_ball_state,
#											"\n",
#											"Distance: ", Global.distance/10, " Speed: ", Global.debug_speed,
#											"\n",
#											"Wind Selecter: ", input_wind_strength, " Wind Strength: ", Global.wind_strength,
#											"\n",
#											"Club Selected: ", Global.club_name,
#											"\n",
#											"Club Distance: ", Global.club_distance,
#											"\n",
#											"Club Power: ", Global.club_power,
#											"\n",
#											"Shot Power: ", Global.power, " Slice:" ,Global.slice,
#											"\n",
#											"Score: ", Global.score)											
func change_state(new_state):
	state = new_state
	match state:
		START:
			Global.wind_picker(input_wind_strength)
			$UI/WindArrow.texture = load(Global.wind_direction[3])
			$UI/WindArrow/WindDirection.text = str(Global.wind_direction[0]," ", Global.wind_strength, " mph")
			$GolfBall.linear_damp = -1 #Resets Linear Damp
			$GolfBall.linear_velocity = Vector2() #Makes sure the ball is stationary
			$GolfBall.position = Vector2(0,0) #Sets Golfball position			
			$Player/FakePlayer.global_position = $GolfBall.global_position #Sets the position of the fake player
			Global.crosshair_pos = $Player/FakePlayer.global_position - $Player/FakePlayer/Crosshair.global_position # Gets Vector 2 between the crosshair and the GolfBall
			$UI/MarginContainer/Distance.hide()
			$UI/MarginContainer2/Spacebar_Continue.hide()
			$UI/ShotLabelHeader/ShotLabel.text = str(Global.shots)
			$GolfBall/GolfballCamera.make_current()
			$GolfBall/AnimatedSprite.show()
			$Animations/WaterSplash.hide()
			$Sprites/BunkerSplash.hide()
			if handedness == "right":
				$Player/AnimatedSprite.animation = "swing_right"
				$Player/AnimatedSprite.stop()
				$Player/AnimatedSprite.frame = 0
			else:
				$Player/AnimatedSprite.position.x = $GolfBall.position.x + 13
				$Player/AnimatedSprite.animation = "swing_left"
				$Player/AnimatedSprite.stop()
				$Player/AnimatedSprite.frame = 0
			Global.debug_ball_state = "Ball at Rest"
		SET_AIM:
			$Player/FakePlayer/Crosshair/CrosshairCamera.make_current()
			$Player/FakePlayer.show() #Reveals Crosshair
		SET_POWER:
			power = 0
			$UI/PowerBarContainer/TexturePowerBar/PowerPip.position = Global.powerpippos
			$GolfBall/GolfballCamera.make_current()
			$UI/PowerBarContainer/TexturePowerBar.show() #Reveals Powerbar
		SET_SLICE:
			slice = 0
			$UI/SliceContainer/Slice/SlicePip.position = Global.slicepippos
			$UI/SliceContainer/Slice.show()
		SHOOT:
			$GolfBall/GolfballCamera.make_current()
			$Player/FakePlayer.hide() #Hide Crosshair
			$UI/PowerBarContainer/TexturePowerBar.hide() # Hide Power Bar
			$UI/SliceContainer/Slice.hide()
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
			$GolfBall.golfball_hit() #passes the Power value determined when the space bar is pressed to the Golfball Node.
#This function controls when we move to the next state.
func _input(event):
	if event.is_action_pressed("ui_cancel"): #press escape at anytime to reset. FIXED.
		reset()
	match state:
		START:
			if event.is_action_pressed("go_to_aiming"):
				change_state(SET_AIM)
			if event.is_action_pressed("ui_accept"):
				change_state(SET_POWER)
		SET_AIM:
			if event.is_action_pressed("go_to_aiming"):
				change_state(START)
			if event.is_action_pressed("ui_accept"):
				change_state(SET_POWER)
		SET_POWER:
			if event.is_action_pressed("ui_accept"):
				change_state(SET_SLICE)
		SET_SLICE:
			if event.is_action_pressed("ui_accept"):
				change_state(SHOOT)			
		SHOOT:
			if ball_stopped == true && Input.is_action_pressed("go_to_start"):
				change_state(START)

func end_of_shot():
	ball_stopped = true #set's this value to true to allow the show_result screen to function normally
	var ball_distance = $GolfBall.global_position - $Player/FakePlayer.global_position
	Global.distance = ball_distance.length()
	if Global.shots < 5:
		Global.shots += 1
	else:
		Global.shots = 0
		Global.score = 0
	show_result()

func stop_all_timers():
	$GolfBall/Timers/StoppedTimer.stop() #Stops All Timers
	$GolfBall/Timers/FallingTimer.stop()
	$GolfBall/Timers/RisingTimer.stop()
	
func show_result():
	$UI/MarginContainer/Distance.show() #shows the distance the ball has travelled
	$UI/MarginContainer/Distance.text = str("You hit the ball", (Global.distance/10), " yds")
	$UI/MarginContainer2/Spacebar_Continue.show()
	$UI/ScoreHeader/Score.text = str(Global.score)
	
func reset():
	$GolfBall.stopGolfBall()
	show_result()
	if ball_stopped == true && Input.is_action_pressed("go_to_start"):
		change_state(START)
		$Golfball.clear_tween()

func _on_GolfBall_object_hit(value): #increases the value if a Telephone box is hit (may need tweaked)
	Global.score += value
	#print(Global.score)

 
func _on_GolfBall_target_score(value):
	Global.score += value
	#print(Global.score)
	end_of_shot()


func _on_GolfBall_water(position):
	$GolfBall/AnimatedSprite.hide()
	$Animations/WaterSplash.animation = "splash"
	$Animations/WaterSplash.frame = 0
	$Animations/WaterSplash.position = position
	$Animations/WaterSplash.show()
	$Animations/WaterSplash.play()
	yield($Animations/WaterSplash,"animation_finished")
	$Animations/WaterSplash.hide()

func _on_GolfBall_bunker(position):
	$GolfBall/AnimatedSprite.hide()
	$Sprites/BunkerSplash.position = position
	$Sprites/BunkerSplash.show()
