extends Camera2D

@export var min_zoom: float = 0.5
@export var max_zoom: float = 1
@export var zoom_speed: float = 1

@export var players: Array[Node] = []
	
func _ready() -> void:
	players = []
	for node in get_tree().get_nodes_in_group("players"):
		if node is Node2D:  players.append(node)


func _process(delta):
	#if players.is_empty():
		#print("⚠ Nenhum jogador detectado pela câmera!")
		#return
		#
	#var total_position = Vector2.ZERO
	#for player in players:
		#print("📍 Posição do", player.name, ":", player.global_position)  # Debug
		##total_position += player.global_position
		##var center_position = total_position / players.size()
		##print("🎥 Nova posição da câmera:", center_position)  # Debug
		##global_position = lerp(global_position, center_position, delta * 5.0)

	if players.is_empty():
		return
	var total_position = Vector2.ZERO
	var max_distance = 0.0
	for player in players:
		total_position += player.global_position
		var center_position = total_position / players.size()
		for i in range(players.size()):
			for j in range(i + 1, players.size()):
				max_distance = max(max_distance, players[i].global_position.distance_to(players[j].global_position))
				global_position = lerp(global_position, center_position, delta * 5.0)
				var target_zoom = clamp(1.0 / (max_distance / 300.0), min_zoom, max_zoom)
				zoom = lerp(zoom, Vector2(target_zoom, target_zoom), zoom_speed * delta)
