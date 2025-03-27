extends Area2D

@onready var collision = $Collision as CollisionShape2D
@onready var lava = $Sprite2D as Sprite2D
@onready var game_manager = get_parent().get_node_or_null("GameManager")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision.shape.size = lava.get_rect().size

func _on_body_entered(body: Node2D) -> void:
	if game_manager and body.is_in_group("players"):
		game_manager.respawn_players()
		body.animation.play("death")  # Toca a animação de morte
	else:
		print("Erro")
