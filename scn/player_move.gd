# Based on Godot's default character mover script.
extends CharacterBody2D

@onready var pixel_perfect = get_node("../..")


var speed: float
const JUMP_VELOCITY: float = -270.0
var perform_wall_jump: bool = false

var perform_coyote_jump: bool = false

func is_player_dashing() -> void:
	
	if Input.is_action_pressed("player_run"):
		speed = 130.0
		
		return
	else:
		speed = 80.0 # Walking speed
		
		return

func player_jump() -> void:
	perform_coyote_jump = false
	velocity.y = JUMP_VELOCITY * pixel_perfect.scale_factor


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta) * pixel_perfect.scale_factor
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		player_jump()
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions
	# with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction and not perform_wall_jump:
		velocity.x = (direction * speed) * pixel_perfect.scale_factor
	elif not perform_wall_jump:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# Wall jumping
	if (
		perform_coyote_jump == false
		and is_on_wall_only()
		and Input.is_action_just_pressed("ui_accept")
	):
		velocity = Vector2(
			(get_wall_normal().x * speed) * pixel_perfect.scale_factor,
			JUMP_VELOCITY * pixel_perfect.scale_factor
			)
		
		perform_wall_jump = true
		
		%TimerWJ.start()
	
	is_player_dashing()
	
	
	# Setup for coyote jump (before move_and_slide() is called)
	var was_on_floor: bool = is_on_floor()
	var was_on_wall: bool = is_on_wall()
	
	
	move_and_slide()
	
	
	if (was_on_floor and not is_on_floor()) or (was_on_wall and not is_on_wall()):
		%TimerCoyote.start()
		perform_coyote_jump = true
	
	# Coyote jump
	if perform_coyote_jump == true and Input.is_action_just_pressed("ui_accept"):
		player_jump()
		perform_coyote_jump == false
	
	print(perform_coyote_jump)


func _on_timer_wj_timeout() -> void:
	perform_wall_jump = false


func _on_timer_coyote_timeout() -> void:
	perform_coyote_jump = false
