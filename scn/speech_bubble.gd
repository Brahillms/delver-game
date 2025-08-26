extends Sprite2D

@onready var test_talker: Sprite2D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


func _on_talker_hitbox_manager_body_entered(_body: Node2D) -> void:
	if not test_talker.shut_up:
		visible = true


func _on_talker_hitbox_manager_body_exited(_body: Node2D) -> void:
	visible = false
