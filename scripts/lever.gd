extends Area2D

@onready var transition = get_parent().get_node("transition")
@export var next_level : String = "res://levels/world_03.tscn"
@export var players: Array[Node] = []
var playersDentro = []

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players") and !next_level == "": 
		if body not in playersDentro:
			playersDentro.append(body)
		
		if playersDentro.size() >= 2:
			transition.change_scene(next_level)
		Global.chave = true
	else:
		print("No scene Loaed")
		

	
func _ready() -> void:
	players = []
	for node in get_tree().get_nodes_in_group("players"):
		if node is Node2D:  players.append(node)
