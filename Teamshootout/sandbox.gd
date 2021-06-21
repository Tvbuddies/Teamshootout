extends Node2D


func ready():
	if Input.is_action_pressed("slowmo"):
		$ColorRect.show()
	else:
		$ColorRect.hide()
