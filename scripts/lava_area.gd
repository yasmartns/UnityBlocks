extends Area2D

@onready var collision = $Collision as CollisionShape2D
@onready var lava = $Sprite2D as Sprite2D
@export var game_manager: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision.shape.size = lava.get_rect().size

func _on_body_entered(body: Node2D) -> void:
	if game_manager:
		game_manager.respawn_players()
		body.animation.play("death")  # Toca a animação de morte
	else:
		print("Erro")
