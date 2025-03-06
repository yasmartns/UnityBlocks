extends Camera2D

@export var move_speed: float = 0.1
@export var zoom_speed: float = 0.05
@export var min_zoom: float = 0.5
@export var max_zoom: float = 3.0
@export var margin: Vector2 = Vector2(100, 50)

var players: Array[Node] = []

@onready var screen_size: Vector2 = get_viewport_rect().size

	

# Adiciona um jogador à lista
func add_player(player: Node):
	if not players.has(player):
		players.append(player)

# Remove um jogador da lista
func remove_player(player: Node):
	if players.has(player):
		players.erase(player)

func _process(delta: float) -> void:
	if players.is_empty():
		return

	var avg_position = Vector2.ZERO
	for player in players:
		avg_position += player.global_position
	
	avg_position /= players.size()
	
	# Interpola a posição da câmera suavemente
	position = position.lerp(avg_position, move_speed)

	# Define o retângulo que engloba todos os jogadores
	var bounds = Rect2(avg_position, Vector2.ZERO)

	for player in players:
		bounds = bounds.expand(player.global_position)

	bounds = bounds.grow_individual(margin.x, margin.y, margin.x, margin.y)

	# Ajusta o zoom para que todos os jogadores fiquem visíveis
	var zoom_factor = min_zoom
	if bounds.size.x > bounds.size.y * (screen_size.x / screen_size.y):
		zoom_factor = clamp(bounds.size.x / screen_size.x, min_zoom, max_zoom)
	else:
		zoom_factor = clamp(bounds.size.y / screen_size.y, min_zoom, max_zoom)

	zoom = zoom.lerp(Vector2.ONE * zoom_factor, zoom_speed)
