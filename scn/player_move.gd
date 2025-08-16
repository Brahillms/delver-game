# Derived from Godot's generic player move script.
extends CharacterBody2D

@onready var pixel_perfect = get_node("../..")

var SPEED: float
var JUMP_VELOCITY: float

func _ready() -> void:
	SPEED = 100.0 * pixel_perfect.scale_factor
	JUMP_VELOCITY = -280.0 * pixel_perfect.scale_factor

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
