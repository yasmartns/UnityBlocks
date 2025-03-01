extends CharacterBody2D


const SPEED = 200.0
const JUMP_FORCE = -250.0

@onready var animation := $Animation as AnimatedSprite2D
var is_jumping := false

var direction = 1
var do_jump = false
var _is_on_floor = true

@export var player_id := 1:
	set(id):
		player_id = id
		%InputSynchronizer.set_multiplayer_authority(id)
		
#func _ready() -> void:
	#if multiplayer.get_unique_id() == player_id:
		#$Camera2D.make_current()
	#else:
		#$Camera2D.enabled = false
		
func _apply_animations(_delta):
	if direction:
		velocity.x = direction * SPEED
		animation.play("run")
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
		elif is_jumping:
			animation.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
	
func _apply_movement_from_input(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		if direction == 0:
			animation.play("idle")
		else:
			animation.play("run")
	else:
		animation.play("jump")
	# Handle jump. attention!!!
	if do_jump and _is_on_floor:
		velocity.y = JUMP_FORCE
		is_jumping = true
		do_jump = false
	elif _is_on_floor:
		is_jumping = false
		
	if direction > 0:
		animation.flip_h = false
	elif direction < 0:
		animation.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = %InputSynchronizer.input_direction

	move_and_slide()

func _physics_process(delta: float) -> void:
	if multiplayer.is_server():
		_is_on_floor = is_on_floor()
		_apply_movement_from_input(delta)
		
	if not multiplayer.is_server():
		_apply_animations(delta)
	
