extends CanvasGroup


var _screen_scale_initialized: bool = false
var scale_factor: int = 1:
	set(value):
		scale_factor = value
		_set_pixel_perfect_size()

# Deisgned to expand the game's internal small, fixed resolution for
# screens with much higher resolutions

func _ready() -> void:
	_set_pixel_perfect_size()

	Global.screen_scale_intitialized.connect(_on_screen_scale_initialized)
	#Engine.time_scale = 0.5


func _set_pixel_perfect_size() -> void:
	%PixelPerfectScreenScaling.scale = Vector2i(scale_factor, scale_factor)
	get_window().size = Vector2i(
	(256 * scale_factor), (192 * scale_factor)
	)
	Global.scale_factor_updated.emit()

# In-game window rescaling
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("inc_screen_scale") and not _screen_scale_initialized:
		if scale_factor <= 5:
			scale_factor += 1
			Global.scale_factor_updated.emit()

	if Input.is_action_just_pressed("dec_screen_scale") and not _screen_scale_initialized:
		if scale_factor >= 2:
			scale_factor -= 1
			Global.scale_factor_updated.emit()


func _on_screen_scale_initialized() -> void:
	_screen_scale_initialized = true
	var player = preload("res://scn/player.tscn").instantiate()
	add_child(player)
