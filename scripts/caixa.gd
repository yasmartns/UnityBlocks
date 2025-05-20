#extends RigidBody2D
#
#@export var max_speed: float = 100.0
#@export var linear_damp_custom: float = 5.0
#
#func _ready():
	#gravity_scale = 0  # Sem gravidade
	#linear_damp = linear_damp_custom  # Desaceleração suave
#
#func _physics_process(delta):
	## Limita a velocidade máxima
	#if linear_velocity.length() > max_speed:
		#linear_velocity = linear_velocity.normalized() * max_speed
extends CharacterBody2D
class_name Caixa

# Velocidade de empurrão
var push_speed = 100.0

# Função de atualização a cada quadro
func _process(delta: float) -> void:
	# Aplica a gravidade (se não estiver no chão)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Aplica o movimento baseado na velocidade
	move_and_slide()

	velocity.x = 0

# Função para empurrar a caixa
func slide_object(direction: Vector2) -> void:
	# Ajusta a velocidade horizontal para empurrar a caixa
	velocity.x = direction.x * push_speed
