extends CanvasGroup

# Deisgned to expand the game's internal small, fixed resolution for screens with much higher resolutions

var pixel_perfect_scale_factor: int = 1:
	set(value):
		pixel_perfect_scale_factor = value
		_set_pixel_perfect_size()

func _ready() -> void:
	_set_pixel_perfect_size()

func _set_pixel_perfect_size() -> void:
	%PixelPerfectScreenScaling.scale = Vector2i(pixel_perfect_scale_factor, pixel_perfect_scale_factor)
	get_window().size = Vector2i(
	(256 * pixel_perfect_scale_factor), (192 * pixel_perfect_scale_factor)
	)

# In-game window rescaling
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inc_screen_scale"):
		if pixel_perfect_scale_factor <= 5:
			pixel_perfect_scale_factor += 1
	
	if Input.is_action_just_pressed("dec_screen_scale"):
		if pixel_perfect_scale_factor >= 2:
			pixel_perfect_scale_factor -= 1
