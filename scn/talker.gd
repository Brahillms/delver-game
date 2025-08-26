extends Sprite2D

var is_within_talking_range: bool = false
var shut_up: bool = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_within_talking_range and not shut_up:
		shut_up = true
		await %TextBoxManager.display_textbox(TextBoxManager.Init.OPENING_CLOSING, "", "", "")


func _on_talker_hitbox_manager_body_entered(_body: Node2D) -> void:
	is_within_talking_range = true


func _on_talker_hitbox_manager_body_exited(_body: Node2D) -> void:
	is_within_talking_range = false
