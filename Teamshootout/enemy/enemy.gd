extends KinematicBody2D

var motion = Vector2.ZERO

func _physics_process(delta):
	move_and_collide(motion)
	var player = get_parent().get_node("player")
	position += (player.position - position)/100
	look_at(player.position)
	if Input.is_action_just_pressed("ui_accept"):
		queue_free()



func _on_Area2D_body_entered(body: Node):
	if body.get_name():
		if "bul" in body.name:
			queue_free()
