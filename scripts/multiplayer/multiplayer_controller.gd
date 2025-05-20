extends CharacterBody2D

@export var speed: float = 200.0
const SPEED = 100.0
const JUMP_FORCE = -400.0

@onready var animation := $Animation as AnimatedSprite2D
var is_jumping := false

@onready var camera := $"../../CameraFollow"

func _ready() -> void:
	add_to_group("players")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump2") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left2", "move_right2")
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

	apply_push_force()
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)

func respawn():
	var respawn_point = get_tree().get_nodes_in_group("spawn")[0]
	print(respawn_point.position)
	if respawn_point:
		position = respawn_point.position
# Quando colidir e apertar botão, empurra a caixa





func apply_push_force():  # Empurra a caixa
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is Caixa:
			var caixa = collision.get_collider() as Caixa
			caixa.slide_object(-collision.get_normal())  # Empurra a caixa para a direção oposta ao normal da colisão
