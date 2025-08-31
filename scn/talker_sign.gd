extends Sprite2D

var is_within_talking_range: bool = false
var shut_up: bool = false
#var _reread_count: int = 0

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_within_talking_range and not shut_up:
		shut_up = true
		await %TextBoxManager.display_textbox(TextBoxManager.Init.OPENING, "", "", "The sign reads:")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "\"Frederich Mining and Excavation Co.\"")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.IDLE, "", "", "\"Estb. 1903\"")
		await %TextBoxManager.display_textbox(TextBoxManager.Init.CLOSING, "", "", "\"Tucson, AZ\"")


func _on_talker_hitbox_manager_body_entered(body: Node2D) -> void:
	if body.get_parent() is Player:
		is_within_talking_range = true


func _on_talker_hitbox_manager_body_exited(body: Node2D) -> void:
	if body.get_parent() is Player:
		is_within_talking_range = false
