extends Node2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D
@export var respawn_point: Marker2D

func respawn_players():
	if player1 and player2 and respawn_point:
		player1.position = respawn_point.position
		player2.position = respawn_point.position
		
