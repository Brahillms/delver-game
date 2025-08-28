extends AudioStreamPlayer


func _ready() -> void:
	Global.entered_cave.connect(_on_entered_cave)


func _on_entered_cave() -> void:
	play()
