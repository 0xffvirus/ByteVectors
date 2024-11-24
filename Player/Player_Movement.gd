extends CharacterBody2D


const SPEED = 500.0 # Base horizontal movement speed
const ACCELERATION = 1200.0 # Base acceleration
const FRICTION = 3500.0 # Base friction
const GRAVITY = 2000.0 # Gravity when moving upwards
const FALL_GRAVITY = 3000.0 # Gravity when falling downwards
const FAST_FALL_GRAVITY = 5000.0 # Gravity while holding "fast_fall"
const WALL_GRAVITY = 10.0 # Gravity while sliding on a wall
const JUMP_VELOCITY = -700.0 # Maximum jump strength
const WALL_JUMP_VELOCITY = -700.0 # Maximum wall jump strength
const WALL_JUMP_PUSHBACK = 300.0 # Horizontal push strength off walls
const INPUT_BUFFER_PATIENCE = 0.1 # Input queue patience time
const COYOTE_TIME = 0.08 # Coyote patience time

var dashDirection = Vector2(1,0)
var canDash = false
var dashing = false
var can_doublejump = true
var input_buffer : Timer # Reference to the input queue timer
var coyote_timer : Timer # Reference to the coyote timer
var coyote_jump_available := true
var idle = true
var isJumping = false


var ghost_scene = preload("res://Player/dash_ghost.tscn")

@onready var sprite = $Sprite2D
@onready var jump_sound = $"../Audio/Jump_Sound"
@onready var dash_sound = $"../Audio/Dash_Sound"

func _ready() -> void:
	get_tree().root.print_tree_pretty()
	add_to_group("player")
	# Set up input buffer timer
	input_buffer = Timer.new()
	input_buffer.wait_time = INPUT_BUFFER_PATIENCE
	input_buffer.one_shot = true
	add_child(input_buffer)

	# Set up coyote timer
	coyote_timer = Timer.new()
	coyote_timer.wait_time = COYOTE_TIME
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	coyote_timer.timeout.connect(coyote_timeout)

func _physics_process(delta) -> void:
	
	dash()
	# Get inputs
	var horizontal_input := Input.get_axis("move_left", "move_right")
	var jump_attempted := Input.is_action_just_pressed("jump")
	if is_on_wall():
		isJumping = true
		$Sprite2D.play("jump")
		
		# Apply gravity and reset coyote jump
	if is_on_floor():
		can_doublejump = true
		coyote_jump_available = true
		coyote_timer.stop()
	else:
		if coyote_jump_available:
			if coyote_timer.is_stopped():
				
				coyote_timer.start()
				
		velocity.y += get_gravityy(horizontal_input) * delta 

	# HYandle horizontal motion and friction
	var floor_damping := 1.0 if is_on_floor() else 0.5 # Set floor damping, friction is less when in air
	# Add the gravity and handle jumping
	if jump_attempted or input_buffer.time_left > 0 :
		if coyote_jump_available: # If jumping on the ground
			velocity.y = JUMP_VELOCITY
			$Sprite2D.play("jump")
			jump_sound.play()
			$Sprite2D/AnimatedSprite2D.play("jump_effect")
			$Sprite2D/AnimatedSprite2D.play("idle")
			coyote_jump_available = false
			isJumping = true
		elif !is_on_floor() and can_doublejump and !is_on_wall():
			velocity.y = JUMP_VELOCITY
			can_doublejump = false
			$Sprite2D.play("double_jump")
			$Sprite2D/AnimatedSprite2D.play("jump_effect")
			isJumping = true
		elif is_on_wall(): # If jumping off a wall
			velocity.y = WALL_JUMP_VELOCITY
			velocity.x = WALL_JUMP_PUSHBACK * -sign(horizontal_input)
		elif jump_attempted: # Queue input buffer if jump was attempted
			
			input_buffer.start()
	elif horizontal_input < 0:
		velocity.x = move_toward(velocity.x, horizontal_input * SPEED, ACCELERATION * delta )
		$Sprite2D.flip_h = true
		$Sprite2D.offset.x = -10
		$Sprite2D/AnimatedSprite2D.flip_h = true
		$Sprite2D/AnimatedSprite2D.offset.x = 10
		if is_on_floor():
			$Sprite2D.play("run")
	elif horizontal_input > 0:
		velocity.x = move_toward(velocity.x, horizontal_input * SPEED, ACCELERATION * delta )
		$Sprite2D.flip_h = false
		$Sprite2D.offset.x = 10
		$Sprite2D/AnimatedSprite2D.flip_h = false
		$Sprite2D/AnimatedSprite2D.offset.x = -10
		if is_on_floor():
			$Sprite2D.play("run")
		
	else:
		velocity.x = move_toward(velocity.x, 0, (FRICTION * delta ) * floor_damping)
		$Sprite2D/AnimatedSprite2D.play("idle")
		idle = true
		if is_on_floor():
			$Sprite2D.play("idle")
		if ($Sprite2D.flip_h):
			$Sprite2D.offset.x = -10
		else:
			$Sprite2D.offset.x = 10

	

	# Apply velocity
	move_and_slide()

## Returns the gravity based on the state of the player
func get_gravityy(input_dir : float = 0) -> float:
	if Input.is_action_pressed("fast_fall"):
		return FAST_FALL_GRAVITY
	if is_on_wall_only() and velocity.y > 0 and input_dir != 0:
		return WALL_GRAVITY
	return GRAVITY if velocity.y < 0 else FALL_GRAVITY

## Reset coyote jump
func coyote_timeout() -> void:
	coyote_jump_available = false

func instance_ghost():
	var ghost: Sprite2D = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
		# these 3 lines are new
	var current_frame_index = sprite.frame
	var frame = sprite.sprite_frames.get_frame_texture("run", current_frame_index)
	ghost.texture = frame
	
	ghost.global_position = global_position
	ghost.scale = Vector2(3,3)
	ghost.flip_h = sprite.flip_h
	
func dash():
	if is_on_floor():
		canDash = true
	if Input.is_action_pressed("move_right"):
		dashDirection = Vector2(1.5,-0.35)
	if Input.is_action_pressed("move_left"):
		dashDirection = Vector2(-1.5,-0.35) 
	
	if Input.is_action_just_pressed("dash") and canDash:
		velocity = dashDirection.normalized() * 1200
		instance_ghost()
		dash_sound.play()
		canDash = false
		dashing = true
		await get_tree().create_timer(0.2).timeout
		dashing = false
		
	
