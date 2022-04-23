extends RigidBody2D

#To Work On: Different states for Golf Ball to help with collisions. Ball Rises for 75% of time (to signify hitting the peak
# before falling for 15% of the time (signified by increasing the speed of deceleration). Finally the bounce which is for 10%.
# Values may change. Time will be different for each club (Driver longest, Wedge shortest)
var ball_stop: Vector2 = Vector2()
signal telephone_box_hit
signal ball_stopped

# Takes in the Power variable from Main.gd and uses it to set the force on the ball.
# Takes in the Vector betwen the Crosshair and the Player
func golfball_hit(power):
	var aim_direction: Vector2 = Global.crosshair_pos
	var force: Vector2 = Vector2((aim_direction.x * -1),(aim_direction.y * -1))
	#set_collision_layers_off()
	linear_damp = -1
	linear_velocity = Vector2(force.normalized()* Global.club_power  * power) # * Golfer_Power) 
	$Timers/RisingTimer.wait_time = 8
	$Timers/RisingTimer.start() #Starts rising timer
	yield($Timers/RisingTimer, "timeout")
	$Timers/RisingTimer.stop()
	$Timers/FallingTimer.wait_time = 3
	$Timers/FallingTimer.start()
	linear_damp = 0.4
	print("Ball Falling")
	set_collision_layers_on()
	yield($Timers/FallingTimer, "timeout")
	$Timers/FallingTimer.stop()
	$Timers/StoppedTimer.wait_time = 3
	$Timers/StoppedTimer.start()
	linear_damp = 1
	print ("Ball Rolling")
	yield($Timers/StoppedTimer, "timeout")
	$Timers/StoppedTimer.stop()
	$Timers/ResultTimer.wait_time = 2
	$Timers/ResultTimer.start()
	linear_velocity = ball_stop
	if linear_velocity == Vector2(0,0):
		print("Ball Stopped")
		emit_signal("ball_stopped")
	
	
	#100 is being used as a stand in for max power
	#2.85 is all the ball to travel 1800 pixels at full power in 14 secs to convert to distance (10pixel = 1 yard)
	#may need more tweaking when Golfer Stats are introduced

func set_collision_layers_off():
	set_collision_mask_bit(2, false)
	set_collision_mask_bit(0, true)
	set_collision_layer_bit(2, false)
	set_collision_layer_bit(0, true)
	
func set_collision_layers_on():
	set_collision_mask_bit(2, true)
	set_collision_mask_bit(0, false)
	set_collision_layer_bit(2, true)
	set_collision_layer_bit(0, false)
	
func stop_timers():
	$Timers/StoppedTimer.stop() #Stops All Timers
	$Timers/FallingTimer.stop()
	$Timers/RisingTimer.stop()
	$Timers/ResultTimer.stop()

func _on_GolfBall_body_entered(body):
	emit_signal("telephone_box_hit", 5)
