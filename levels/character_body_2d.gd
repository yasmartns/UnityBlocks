extends CharacterBody2D

@onready var player1 = $"../Player"
@onready var player2 = $"../MultiplayerPlayer"
@onready var camera = $Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.limit_left = -34
	camera.limit_right = 750
	camera.limit_top = 0
	camera.limit_bottom = 384


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distancia_x = abs(player1.position.x - player2.position.x)
	var distancia_y = abs(player1.position.y - player2.position.y)
	
	if (player1.position.x < player2.position.x):
		self.position.x = player1.position.x + (distancia_x/2)
	else:
		self.position.x = player2.position.x + (distancia_x/2)
		
	if (player1.position.y < player2.position.y):
		self.position.y = player1.position.y + (distancia_y/2)
	else:
		self.position.y = player2.position.y + (distancia_y/2)
		
	camera.zoom.x = 1 - 1/(3200/distancia_x)
	if camera.zoom.x < 0.4:
		camera.zoom.x = 0.4
	camera.zoom.y = 1 - 1/(3200/distancia_x)
	if camera.zoom.y < 0.4:
		camera.zoom.y = 0.4
