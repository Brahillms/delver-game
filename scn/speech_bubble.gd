extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


func _on_talker_hitbox_manager_body_entered(_body: Node2D) -> void:
	visible = true


func _on_talker_hitbox_manager_body_exited(_body: Node2D) -> void:
	visible = false
