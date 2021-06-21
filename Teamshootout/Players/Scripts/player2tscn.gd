extends KinematicBody2D

var MAX_SPEED = 1000
var ACCELERATION = 3000
var motion = Vector2.ZERO

func _physics_process(delta):
	var axis = get_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func get_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("p2r")) - int(Input.is_action_pressed("p2l"))
	axis.y = int(Input.is_action_pressed("p2d")) - int(Input.is_action_pressed("p2u"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
