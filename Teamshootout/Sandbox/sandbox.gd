extends Node2D

var enemy_1 = preload("res://enemy/enemy.tscn")


func _on_enemyspawntimer_timeout() -> void:
	var enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	while enemy_position.x < 640 and enemy_position.x > -80 or enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	Global.instance_node(enemy_1, enemy_position, self)
