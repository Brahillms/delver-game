extends Sprite2D

var is_within_talking_range: bool = false
var shut_up: bool = false
#var _reread_count: int = 0

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_within_talking_range and not shut_up:
		shut_up = true
		await %TextBoxManager.display_textbox(TextBoxManager.Init.OPENING, "", "", "Yo it's me, the foreman.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking", "Um, hi sir!")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_right", "I'm looking for someone here.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "And who would that be?")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_left", "My... brother.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_left", "He used to work here.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_left", "And for some reason, one day...")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "pensive", "...he never came back home, and vanished.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "You really think you'll find him down here?")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.CLOSING, "", "", "Forget it, kid. You'll never find him.")



func _on_talker_hitbox_manager_body_entered(_body: Node2D) -> void:
	is_within_talking_range = true


func _on_talker_hitbox_manager_body_exited(_body: Node2D) -> void:
	is_within_talking_range = false
