extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

var can_laser = true
var can_grenade = true

@export var max_speed = 500
var speed = max_speed

func hit():
	Globals.health -= 10


func _process(_delta):
	# input (e.g. (-1,0) to move left).
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	# rotate
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		
		can_laser = false
		$Timer.start()
		
		laser.emit(selected_laser.global_position, player_direction)
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var pos = $LaserStartPositions.get_children()[0].global_position
		
		can_grenade = false
		$GrenadeReloadTimer.start()
		grenade.emit(pos, player_direction)


func _on_timer_timeout():
	can_laser = true


func _on_grenade_reload_timer_timeout():
	can_grenade = true
