extends Node


signal entered_cave
signal all_collectables_collected


var collected_count: int = 0
var set_respawn_loc: Vector2


func _ready() -> void:
	entered_cave.connect(_on_entered_cave)
	all_collectables_collected.connect(_on_all_collectables_collected)


func _on_entered_cave() -> void:
	pass


func _on_all_collectables_collected() -> void:
	pass
