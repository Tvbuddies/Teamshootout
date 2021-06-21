extends KinematicBody2D

var motion = Vector2.ZERO

func _physics_process(delta):
	move_and_collide(motion)
	var player = get_parent().get_node("player")
	position += (player.position - position)/100
	look_at(player.position)





func _on_Hitbox2_body_entered(body):
	if "bullet" in body.name:
		queue_free()

