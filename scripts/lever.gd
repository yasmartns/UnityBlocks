extends Area2D

@onready var transition = get_parent().get_node("transition")
@export var next_level : String = ""
@export var players: Array[Node] = []

func _on_body_entered(body: Node) -> void:
	if body.name == "Player" and !next_level == "": 
		transition.change_scene(next_level)
		Global.chave = true
	else:
		print("No scene Loaed")
		

	
func _ready() -> void:
	players = []
	for node in get_tree().get_nodes_in_group("players"):
		if node is Node2D:  players.append(node)
