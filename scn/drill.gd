class_name Drill extends Sprite2D

enum DrillState { IDLE, MOVING, RESETTING }

@export var max_dist: float
@export var move_speed: float
@onready var pixel_perfect = get_parent()
@onready var initial_pos: Vector2 = position  # Just store the actual initial position
@onready var base_move_speed: float = move_speed  # Store the base move speed
@onready var reset_del: float = 1.0

var cur_state: DrillState = DrillState.IDLE
var reset_timer: float = 0.0
var last_scale_factor: float

# Only move speed scales with window resize, max_dist stays constant
var current_move_speed: float:
	get:
		return base_move_speed

func _ready() -> void:
	last_scale_factor = pixel_perfect.scale_factor

func _physics_process(delta: float) -> void:
	match cur_state:
		DrillState.IDLE:
			pass
		DrillState.MOVING:
			move_down(delta)
		DrillState.RESETTING:
			reset_pos(delta)
			reset_timer -= delta
			if reset_timer <= 0:
				cur_state = DrillState.IDLE

func reset_pos(delta: float):
	var new_y: float = position.y - current_move_speed * delta
	if new_y <= initial_pos.y:
		position.y = initial_pos.y
		cur_state = DrillState.IDLE
	else:
		position.y = new_y

func move_down(delta: float):
	var new_y: float = position.y + current_move_speed * delta
	if new_y - initial_pos.y >= max_dist:
		position.y = initial_pos.y + max_dist
		start_reset()
	else:
		position.y = new_y

func start_reset():
	cur_state = DrillState.RESETTING
	reset_timer = reset_del

func _on_test_tile_drill_checker_body_entered(body: Node2D) -> void:
	if body.get_parent() is Player and cur_state == DrillState.IDLE:
		print("Player entered - starting drill")
		cur_state = DrillState.MOVING

func _on_test_tile_drill_checker_body_exited(body: Node2D) -> void:
	# Don't interrupt the drilling sequence - let it complete naturally
	pass
