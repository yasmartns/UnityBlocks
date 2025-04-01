extends Node2D

@onready var texture = $texture
@onready var area_sign = $area_sign

const lines: Array[String] = [
	"Ola, colegas!",
	"E muito bom te ve-los por aqui",
	"Espero que esteja, preparados...",
	"Sua jornada esta apenas...",
	"...COMEÇANDO!",
]

func _unhandled_input(event: InputEvent) -> void:
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogueManager.is_message_active:
			texture.hide()
			DialogueManager.start_message(global_position, lines)
		else:
			texture.hide()
			if DialogueManager.dialog_box != null:
				DialogueManager.dialog_box.queue_free()
				DialogueManager.is_message_active = false 
