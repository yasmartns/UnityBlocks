extends Area2D

@export var death_sound: AudioStreamPlayer2D
@export var player_group: String = "player" # ou use nome direto

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group(player_group):
		death_sound.play()
		body.queue_free()  # Remove o personagem da cena
