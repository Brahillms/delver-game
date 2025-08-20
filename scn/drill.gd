class_name Drill extends Sprite2D


@onready var initial_position: Vector2 = Vector2(position.x, position.y)


func _on_test_tile_drill_checker_body_entered(body: Node2D) -> void:
	if body.get_parent() is Player:
		
		var _player: Player = body.get_parent()


func _on_test_tile_drill_checker_body_exited(_body: Node2D) -> void:
	%TimerDrillResetPos.start()


func _on_timer_drill_reset_pos_timeout() -> void:
	move_toward(position.y, initial_position.y, 30)
