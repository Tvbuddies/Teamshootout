extends KinematicBody2D


var pl = preload("res://Players/bullet.tscn")
var bullet_speed = 1000
var MAX_SPEED = 1000
var ACCELERATION = 3000 
var motion = Vector2.ZERO
var can_fire = true
var fire_rate = 0.2

func _process(delta):
	look_at(get_global_mouse_position())

func _physics_process(delta):
	var axis = get_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)
	
	#gun
	if Input.is_action_pressed("p1s") and can_fire:
		var bullet = pl.instance()
		bullet.position = position
		bullet.rotation_degrees = rotation_degrees
		bullet.apply_impulse(Vector2(), Vector2(bullet_speed, 1).rotated(rotation))
		get_tree().current_scene.add_child(bullet)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		
	#slowmo
	if Input.is_action_pressed("slowmo"):
		Engine.time_scale = 0.1
	else:
		Engine.time_scale = 1



func get_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("p1r")) - int(Input.is_action_pressed("p1l"))
	axis.y = int(Input.is_action_pressed("p1d")) - int(Input.is_action_pressed("p1u"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)


func kill():
	get_tree().reload_current_scene()


func _on_Hitbox_body_entered(body: Node):
	if "enemy" in body.name:
		kill()
