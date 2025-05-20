extends RigidBody2D

@export var max_speed: float = 100.0
@export var linear_damp_custom: float = 5.0

func _ready():
	# Aplica amortecimento para que a caixa desacelere ao parar
	linear_damp = linear_damp_custom
	gravity_scale = 0  # Para evitar queda, caso use gravidade global

func _physics_process(delta):
	# Limita a velocidade da caixa
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
