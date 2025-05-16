extends Area2D

@onready var transition = get_parent().get_node("transition")
@export var next_level : String = "res://levels/world_02.tscn"
@export var players: Array[Node] = []
@export var objetivo: int = 0
var playersDentro = []

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players") and !next_level == "": 
		if body not in playersDentro:
			playersDentro.append(body)
		
		if playersDentro.size() >= 2 and %GameManager.score >= objetivo:
			transition.change_scene(next_level)
			print("TESTE", objetivo)
		Global.chave = true
	else:
		print("No scene Loaded")
		

	
func _ready() -> void:
	players = []
	for node in get_tree().get_nodes_in_group("players"):
		if node is Node2D:  players.append(node)
