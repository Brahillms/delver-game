extends Area2D


func _hurt() -> void:
	print("Ow!")


func _on_area_entered(_area: Area2D) -> void:
	_hurt()
