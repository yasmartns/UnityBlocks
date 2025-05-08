extends Area2D

var isOverDoor := false
@export var objetivo: int
@export var destino: PackedScene


func _on_Door_body_entered(body: Node2D) -> void:
	isOverDoor = true
	if body.is_in_group("players"):
		var score = %GameManager.score
		print(score)
		#if score >= objetivo:
			#get_tree().change_scene_to_packed(destino)
	
func _on_Door_body_exited(body: Node2D) -> void:
	isOverDoor = false
		
func _physics_process(delta: float) -> void:
	if isOverDoor:
		$AnimatedSprite2D.play("open")
	
