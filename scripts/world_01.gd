extends Node2D

func become_host():
	print("Become host pressed")
	%MultiplayerHUD.hide()
	MultiplayerManager.become_host()
	
func join_as_player_2():
	print("Join as player 2")
	%MultiplayerHUD.hide()
	MultiplayerManager.join_as_player_2()
	


func _ready() -> void:
	pass
	
func _on_lever_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
