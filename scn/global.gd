extends Node


signal entered_cave


func _ready() -> void:
	entered_cave.connect(_on_entered_cave)


func _on_entered_cave():
	pass
