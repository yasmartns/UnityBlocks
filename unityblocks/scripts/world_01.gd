extends Node2D
@onready var camera := $Camera as Camera2D

func _ready() -> void:
	camera.add_players($Player)
	camera.add_players($MultiplayerPlayer)

func become_host():
	print("Become host pressed")
	%MultiplayerHUD.hide()
	MultiplayerManager.become_host()
	
func join_as_player_2():
	print("Join as player 2")
	%MultiplayerHUD.hide()
	MultiplayerManager.join_as_player_2()
