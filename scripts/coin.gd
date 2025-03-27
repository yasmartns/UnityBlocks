extends Area2D

@onready var sound = $CoinSound  # Obtém o nó de som

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	$anim.play("collect")
	sound.playing = true
 
func _on_anim_animation_finished() -> void:
	queue_free()




  
