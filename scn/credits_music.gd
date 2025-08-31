extends AudioStreamPlayer

func _ready() -> void:
	Global.roll_credits.connect(_on_roll_credits)


func _on_roll_credits() -> void:
	play()
