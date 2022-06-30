extends RigidBody2D

#To Work On: Different states for Golf Ball to help with collisions. Ball Rises for 75% of time (to signify hitting the peak
# before falling for 15% of the time (signified by increasing the speed of deceleration). Finally the bounce which is for 10%.
# Values may change. Time will be different for each club (Driver longest, Wedge shortest)
var ball_stop: Vector2 = Vector2()
var rotation_stop = Vector3()
var ball_in_outer: bool = false
var ball_in_middle: bool = false
var ball_in_inner: bool = false
export var wind_strength: int
var wind_zero: Vector2 = Vector2()
var ball_moving: bool = false
var enter_outer_circle: bool = false
var enter_middle_circle: bool = false
var enter_inner_circle: bool = false
signal object_hit
signal ball_stopped
signal target_score
signal water
signal bunker

# Takes in the Power variable from Main.gd and uses it to set the force on the ball.
# Takes in the Vector betwen the Crosshair and the Player
func golfball_hit():
	$AnimatedSprite.play()
	ball_moving = true
	var aim_direction: Vector2 = Global.crosshair_pos
	var force: Vector2 = Vector2((aim_direction.x * -1),(aim_direction.y * -1))
	set_collision_layers_off()
	#set_collision_layers_on()
#	print("GB Layer: ",collision_layer, " GB Mask: ", collision_mask)
	linear_damp = -1
	linear_velocity = Vector2(force.normalized()* Global.club_power  * Global.power * Global.golfer_power)
	add_force(Vector2(), Global.wind_direction[1] * Global.wind_strength)
	apply_impulse(Vector2(0,0), Vector2(1,0) * Global.slice * 2) #* value of the slice #This is the slice, how well the player hit the shot
#	print("Speed at hit ", linear_velocity.length())
	Global.debug_ball_state = "Ball Hit"
	$Timers/RisingTimer.wait_time = 8
	$Timers/RisingTimer.start() #Starts rising timer
	rising_animation()
	yield($Timers/RisingTimer, "timeout")
	$Timers/RisingTimer.stop()
	$Timers/FallingTimer.wait_time = 3
	$Timers/FallingTimer.start()
	falling_animation()
	linear_damp = 0.4
#	print("Speed at fall ", linear_velocity.length())
	Global.debug_ball_state = "Ball Falling"
	yield($Timers/FallingTimer, "timeout")
	set_collision_layers_on()
#	print("GB Layer: ",collision_layer, " GB Mask: ", collision_mask)
	$Timers/FallingTimer.stop()
	linear_damp = 1
	self.set_applied_force(Vector2(0,0))
	Global.debug_ball_state = "Ball Rolling"
	
	
	#100 is being used as a stand in for max power
	#2.85 is all the ball to travel 1800 pixels at full power in 14 secs to convert to distance (10pixel = 1 yard)
	#may need more tweaking when Golfer Stats are introduced

func set_collision_layers_off():
	$Area2D.set_collision_mask(0)
	$Area2D.set_collision_layer(0)
	self.set_collision_mask(0)
	self.set_collision_layer(0)
	
func set_collision_layers_on():
	$Area2D.set_collision_mask(141)
	self.set_collision_mask(141)
	$Area2D.set_collision_layer(141)
	self.set_collision_layer(141)
	
func stop_timers():
	$Timers/StoppedTimer.stop() #Stops All Timers
	$Timers/FallingTimer.stop()
	$Timers/RisingTimer.stop()
	$Timers/ResultTimer.stop()

func _on_GolfBall_body_entered(body):
	if body.is_in_group("car"):
#		print("Yes you hit the car")
		emit_signal("object_hit",10)
		#linear_velocity = ball_stop
		angular_velocity = 0
	if body.is_in_group("telephone_box"):
#		print("Yes you hit the telephone box")
		emit_signal("object_hit", 5)
		#linear_velocity = ball_stop	
		angular_velocity = 0
	if body.is_in_group("postbox"):
#		print("Yes you hit the post box")
		emit_signal("object_hit", 1)
		#linear_velocity = ball_stop
		angular_velocity = 0
	if body.is_in_group("bucket"):
#		print("Yes you hit the bucket")
		$Golfball.hide()
		emit_signal("object_hit", 2)
		#linear_velocity = ball_stop
		angular_velocity = 0

#func _process(_delta):
#	Global.debug_speed = linear_velocity.length()

func _integrate_forces(_state):
	if ball_moving == true:
			if linear_velocity.length() < 1.5:
				self.set_applied_force(Vector2(0,0))
				stopGolfBall()

func stopGolfBall():
	set_applied_force(Vector2())
	linear_velocity = ball_stop
	$AnimatedSprite.stop()
	stop_timers()
	Global.debug_ball_state = "Ball Stopped"
#	print(enter_outer_circle)
#	print(enter_middle_circle)
#	print(enter_inner_circle)
	if_ball_in_target()	
	
func if_ball_in_target():	
	if enter_outer_circle == true:
		emit_signal("target_score",2)
#		print("You landed in the Outer")
		ball_moving = false
	elif enter_middle_circle == true:
		emit_signal("target_score",5)
#		print("You landed in the Middle")
		ball_moving = false
	elif enter_inner_circle == true:
		emit_signal("target_score",10)
#		print("You landed in the Inner")
		ball_moving = false
	else:
		emit_signal("ball_stopped")
		ball_moving = false

func _on_Area2D_area_entered(area):
	if area.is_in_group("bunker"):
		Global.debug_ball_state = "Bunker_Area"
		linear_damp = 40
		emit_signal("bunker", position)
	if area.is_in_group("water"):
		Global.debug_ball_state = "Splish Splash"
		linear_damp = 40
		emit_signal("water", position)
	if area.is_in_group("outer_circle"):
		enter_outer_circle = true
	if area.is_in_group("middle_circle"):
		enter_middle_circle = true
	if area.is_in_group("inner_circle"):
		enter_inner_circle = true
	if area.is_in_group("light_rough"):
		linear_damp = 2
	if area.is_in_group("heavy_rough"):
		linear_damp = 4
		

func rising_animation():
	$AnimatedSprite/RisingTween.interpolate_property($AnimatedSprite, 'scale', $AnimatedSprite.scale,
									$AnimatedSprite.scale * 4, 7, Tween.TRANS_LINEAR,
									Tween.EASE_OUT)
	$AnimatedSprite/RisingTween.start()
	
func falling_animation():
	$AnimatedSprite/RisingTween.interpolate_property($AnimatedSprite, 'scale', $AnimatedSprite.scale,
									$AnimatedSprite.scale * 0.25, 3, Tween.TRANS_LINEAR,
									Tween.EASE_OUT)
	$AnimatedSprite/RisingTween.start()

func _on_Area2D_area_exited(area):
	if area.is_in_group("outer_circle"):
		enter_outer_circle = false
	if area.is_in_group("middle_circle"):
		enter_middle_circle = false
	if area.is_in_group("inner_circle"):
		enter_inner_circle = false
	
	
