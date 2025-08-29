class_name WorldCam extends Camera2D


var _is_advancing: bool = false


func _advance(dir: Vector2i) -> void:
	_is_advancing = true
	position_smoothing_enabled = true
	dir *= Vector2i(256, 192)
	position += Vector2(dir)
	
	$Timer.start()
	
	$PlayerRetriggerBufferT.position += Vector2(9999, 9999)
	
	await $Timer.timeout
	
	$PlayerRetriggerBufferT.position -= Vector2(9999, 9999)
	
	_is_advancing = false
	position_smoothing_enabled = false


func _ready() -> void:
	Global.entered_cave.connect(_on_entered_cave)


func _on_entered_cave() -> void:
	position += Vector2(256 * 2, -192)


func _on_advance_screen_t_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(0, -1))


func _on_advance_screen_r_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(1, 0))


func _on_advance_screen_b_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(0, 1))


func _on_advance_screen_l_body_entered(_body: Node2D) -> void:
	if not _is_advancing:
		await _advance(Vector2i(-1, 0))
