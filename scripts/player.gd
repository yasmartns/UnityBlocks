extends CharacterBody2D

func _enter_tree() -> void:#multiplayer 2
	set_multiplayer_authority(name.to_int())
	
const SPEED = 300.0
const JUMP_FORCE = -400.0

@onready var animation := $Animation as AnimatedSprite2D
var is_jumping := false

@onready var camera := $"../../CameraFollow"

func _ready():
	add_to_group("players")  # Adiciona automaticamente ao grupo "players"

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority(): #multiplayer 2
		velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * 400
	move_and_slide()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
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


	move_and_slide()
