extends Area2D
@onready var anim = $AnimatedSprite2D
@export var plataforma: StaticBody2D

func _ready():
	if plataforma:
		anim.play("idle")
		plataforma.get_node("Sprite2D").hide()
		var colisao = plataforma.get_node("CollisionShape2D")
		colisao.set_deferred("disabled", true)
	else:
		print("ERRO: Plataforma não encontrada!")

func _on_body_entered(body):
	if body.is_in_group("players"):
		anim.play("pressed")
		plataforma.get_node("Sprite2D").show()
		var colisao = plataforma.get_node("CollisionShape2D")
		colisao.set_deferred("disabled", false)
		

func _on_body_exited(body):
	if body.is_in_group("players"):
		anim.play("idle")
		plataforma.get_node("Sprite2D").hide()
		var colisao = plataforma.get_node("CollisionShape2D")
		colisao.set_deferred("disabled", true)
