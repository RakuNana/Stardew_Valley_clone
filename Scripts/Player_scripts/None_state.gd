extends Node


@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")
var player_state = null

func enter(_get_tilemap , _tile_data):
	
	#DO NOTHING!
	pass
	
	
func get_current_state(current_state):
	
	player_state = current_state
	
	return player_state
	
	

