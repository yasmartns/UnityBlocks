extends Camera2D
@export var min_zoom: float = 1
@export var max_zoom: float = 1.4
@export var zoom_speed: float = 1.5

@export var players: Array[Node] = []

func _ready() -> void:
	# Inicializa os jogadores a partir do grupo "players"
	players = []
	for node in get_tree().get_nodes_in_group("players"):
		if node is Node2D:
			players.append(node)

func _process(delta):
	# Se não houver jogadores, não faz nada
	if players.is_empty():
		return
	
	# Calcula a posição central entre todos os jogadores
	var total_position = Vector2.ZERO
	var max_distance = 0.0
	for player in players:
		total_position += player.global_position
		
	# Média da posição dos jogadores (posição central)
	var center_position = total_position / players.size()
	
	# Calcula a maior distância entre os jogadores para ajustar o zoom
	for i in range(players.size()):
		for j in range(i + 1, players.size()):
			max_distance = max(max_distance, players[i].global_position.distance_to(players[j].global_position))
	
	# Suaviza a posição da câmera
	global_position = lerp(global_position, center_position, delta * 5.0)
	
	# Ajusta o zoom com base na maior distância entre os jogadores
	var target_zoom = clamp(1.0 / (max_distance / 300.0), min_zoom, max_zoom)
	zoom = lerp(zoom, Vector2(target_zoom, target_zoom), zoom_speed * delta)
