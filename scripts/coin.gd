extends Area2D

@onready var sound = $CoinSound  # Obtém o nó de som
@onready var game_manager = %GameManager

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	$anim.play("collect")
	sound.playing = true
 
func _on_anim_animation_finished() -> void:
	queue_free()




  
