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
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "Forget it, kid. You'll never find him.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "He got knocked on the head and died.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "It's quite a common occurance down here.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "frazzled", "...")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_left", "The thing is, I don't exactly buy that story.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_left", "Something doesn't add up...")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "pensive", "...about the way he disappeared.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "talking_looking_left", "And I got to figure out just what that is.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "Well, I have to take you out of here.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "It's not safe to let civilians wander here.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "flabbergasted", "...")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "frazzled", "...")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "player", "pensive", "Okay, if you say so.")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.CLOSING, "player", "pensive", "I'll come back for you later, brother.")
		Global.roll_credits.emit()


func _on_talker_hitbox_manager_body_entered(body: Node2D) -> void:
	if body.get_parent() is Player:
		is_within_talking_range = true


func _on_talker_hitbox_manager_body_exited(body: Node2D) -> void:
	if body.get_parent() is Player:
		is_within_talking_range = false
