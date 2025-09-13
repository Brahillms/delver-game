class_name TextBoxManager extends AnimatedSprite2D


enum Init { OPENING, IDLE, CLOSING, OPENING_CLOSING }


var is_currently_talking: bool = false
var _speaking_voice : AudioStreamPlayer


@onready var _visible_chars: int = %TextBoxContents.visible_characters


func _init_textbox() -> void:
	is_currently_talking = true
	visible = true
	play("opening")
	await animation_finished

	play("idle")
	%PlayerEmotions.visible = true
	%TextBoxContents.visible = true


func _deinit_textbox() -> void:
	%PlayerEmotions.visible = false
	%TextBoxContents.visible = false
	play("closing")
	await animation_finished

	visible = false
	is_currently_talking = false


func _advance() -> void:
	while not Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame


func display_textbox(init: TextBoxManager.Init,
voice: String,
emotion: String,
message: String) -> void:

	match init:
		Init.OPENING:
			await _init_textbox()
		Init.OPENING_CLOSING:
			await _init_textbox()

	# Handle dialogue speaking voice
	match voice:
		"player":
			_speaking_voice = get_node("%TextVoicePlayer")
		_:
			_speaking_voice = get_node("%TextVoiceNormal")

	# Handle dialogue emotion
	if emotion != "":
		%PlayerEmotions.set_animation(emotion)
	else:
		%PlayerEmotions.set_animation("none")

	# Handle dialogue message
	if message != "":
		%TextBoxContents.set_text("* " + message)
	else: # Failsafe text
		%TextBoxContents.set_text("* I forgot what I was gonna say.")

	%PlayerEmotions.play()

	# Text scroll
	while _visible_chars < %TextBoxContents.text.length():
		_visible_chars += 1

		# Do not play sound for whitespace characters
		if %TextBoxContents.text[_visible_chars - 1] != " ":
			_speaking_voice.pitch_scale = randf_range(0.97, 1.03)

			_speaking_voice.play()


		%TextBoxContents.set_visible_characters(_visible_chars)
		$Timer.start()
		await $Timer.timeout

	%PlayerEmotions.pause()

	# Wait until the player has read the dialog

	await _advance()

	_visible_chars = 2

	match init:
		Init.CLOSING:
			await _deinit_textbox()
		Init.OPENING_CLOSING:
			await _deinit_textbox()

func _physics_process(_delta: float) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	%PlayerEmotions.visible = false
	%TextBoxContents.visible = false
