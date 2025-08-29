class_name UnlockDoorCollectable extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_parent() is Player:
		Global.collected_count += 1 #It's not going up? Why?
		queue_free()


func _physics_process(_delta: float) -> void:
	if Global.collected_count == 5:
		Global.all_collectables_collected.emit()
