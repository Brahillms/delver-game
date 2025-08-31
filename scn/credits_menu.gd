extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	Global.roll_credits.connect(_on_roll_credits)


func _on_roll_credits() -> void:
	visible = true
	$Timer.start()
	await $Timer.timeout
	$RichTextLabel.set_text("A Game by Nearsighted Parsnips")
	await $Timer.timeout
	$RichTextLabel.set_text("Basically everything (art, music, code) by just me, lmao")
	await $Timer.timeout
	$RichTextLabel.set_text("Powered by:")
	await $Timer.timeout
	$RichTextLabel.set_text("Godot Engine v4.4.1 (MIT License)")
	await $Timer.timeout
	$RichTextLabel.set_text("Music and sounds: Ardour v8.12.0")
	await $Timer.timeout
	$RichTextLabel.set_text("JSFXR (sfxr.me/)")
	await $Timer.timeout
	$RichTextLabel.set_text("Created for the Lymitz Game Jam #1")
	await $Timer.timeout
	$RichTextLabel.set_text("Special thanks to:")
	await $Timer.timeout
	$RichTextLabel.set_text("@gampe7068 (for agonizing with me over The Box™)")
	await $Timer.timeout
	$RichTextLabel.set_text("@althalt (for letting me ping them when the game's finished)")
	await $Timer.timeout
	$RichTextLabel.set_text("And you, for playing!")
	await $Timer.timeout
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
