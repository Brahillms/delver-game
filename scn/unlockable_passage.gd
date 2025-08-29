extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.all_collectables_collected.connect(_on_all_collectables_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass


func _on_all_collectables_collected() -> void:
	queue_free()
