extends StaticBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass


func _on_test_tile_drill_checker_body_entered(body: Node2D) -> void:
	if body.get_parent() is Player:
		var _player: Player = body.get_parent()
