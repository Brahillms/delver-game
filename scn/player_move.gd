# Based on Godot's default character mover script.
extends CharacterBody2D


var _perform_wall_jump: bool = false
var _perform_coyote_jump: bool = false
var _is_respawning: bool = false

# I don't know why this works and not just putting %PixelPerfectScreenScaling
# as there's no way to guaruntee the grandparent node is the CanvasGroup node
@onready var pixel_perfect = get_node("../..")
@onready var textbox_manager = get_parent().get_node("%TextBoxManager")


func player_jump() -> void:
	_perform_coyote_jump = false
	%JumpSFX.pitch_scale = randf_range(0.95, 1.05)
	%JumpSFX.play()
	velocity.y = Player.JUMP_VELOCITY * pixel_perfect.scale_factor
	%PlayerAnims.play("jump")


func _ready() -> void:
	get_parent().has_died.connect(_on_has_died)


func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta) * pixel_perfect.scale_factor

	# Handle jump.
	if (Input.is_action_just_pressed("ui_accept")
	and is_on_floor()
	and not textbox_manager.is_currently_talking
	and not _is_respawning
	):
		player_jump()


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions
	# with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")

	# Walking animation
	if direction == 0 and is_on_floor_only():
		%PlayerAnims.play("idle")
	elif direction != 0 and is_on_floor_only():
		%PlayerAnims.play("walk")


	if (direction
	and not _perform_wall_jump
	and not textbox_manager.is_currently_talking
	and not _is_respawning
	):
		velocity.x = (direction * Player.SPEED) * pixel_perfect.scale_factor

	elif (not _perform_wall_jump
	and not textbox_manager.is_currently_talking
	and not _is_respawning):
		velocity.x = move_toward(velocity.x, 0, Player.SPEED)

# Player sprite looking directions
	if direction > 0:
		%PlayerAnims.flip_h = false
	elif direction < 0:
		%PlayerAnims.flip_h = true


	# Wall jumping
	if (
		_perform_coyote_jump == false
		and is_on_wall_only()
		and Input.is_action_just_pressed("ui_accept")
	):
		velocity = Vector2(
			(get_wall_normal().x * Player.SPEED) * pixel_perfect.scale_factor,
			Player. JUMP_VELOCITY * pixel_perfect.scale_factor
			)

		_perform_wall_jump = true

		%TimerWJ.start()


	# Setup for coyote jump (before move_and_slide() is called)
	var was_on_floor: bool = is_on_floor()
	var was_on_wall: bool = is_on_wall()

# Wall slide sprite
	if is_on_wall_only():
		%WallSlideSFX.set_volume_linear(1.0)
	else:
		%WallSlideSFX.set_volume_linear(0.0)


	move_and_slide()

	# Coyote jump setup
	if (was_on_floor and not is_on_floor()) or (was_on_wall and not is_on_wall()):
		%TimerCoyote.start()
		_perform_coyote_jump = true

	# Coyote jump action
	if _perform_coyote_jump == true and Input.is_action_just_pressed("ui_accept"):
		player_jump()
		_perform_coyote_jump = false


	# Landing on ground sfx
	if not was_on_floor and is_on_floor():
		%LandGroundSFX.pitch_scale = randf_range(0.95, 1.05)
		%LandGroundSFX.play()

	# Falling sprite
	if velocity.y > 0 and (
		not is_on_wall()
		and not is_on_floor()
		):

		%PlayerAnims.play("fall")

	# Textbox initialized
	if textbox_manager.is_currently_talking:
		velocity = Vector2(0, 0)


func _on_timer_wj_timeout() -> void:
	_perform_wall_jump = false


func _on_timer_coyote_timeout() -> void:
	_perform_coyote_jump = false


func _on_has_died() -> void:
	_is_respawning = true
	await get_node("../HurtSFX").finished
	global_position = Vector2.ZERO + (Global.respawn_loc * pixel_perfect.scale_factor)
	_is_respawning = false
