class_name WorldCam extends Camera2D


var _is_advancing: bool = false


func _advance(dir: Vector2i) -> void:
	_is_advancing = true
	position_smoothing_enabled = true
	dir *= Vector2i(256, 192)
	position += Vector2(dir)
	
	$Timer.start()
	await $Timer.timeout
	
	_is_advancing = false
	position_smoothing_enabled = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(_is_advancing)


func _on_advance_screen_t_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(0, 1))


func _on_advance_screen_r_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(1, 0))


func _on_advance_screen_b_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(0, -1))


func _on_advance_screen_l_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(-1, 0))
