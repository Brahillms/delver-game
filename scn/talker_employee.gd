extends Sprite2D

var is_within_talking_range: bool = false
var shut_up: bool = false
#var _reread_count: int = 0

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_within_talking_range and not shut_up:
		shut_up = true
		await %TextBoxManager.display_textbox(TextBoxManager.Init.OPENING, "player", "talking", "H-hey there.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_left", "Do you know where the foreman is?")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "The foreman...")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "He's down there to the right.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "He should be in his office.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.CLOSING, "player", "talking", "Okay, thanks a lot!")



func _on_talker_hitbox_manager_body_entered(_body: Node2D) -> void:
	is_within_talking_range = true


func _on_talker_hitbox_manager_body_exited(_body: Node2D) -> void:
	is_within_talking_range = false
