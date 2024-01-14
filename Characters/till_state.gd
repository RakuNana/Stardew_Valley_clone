extends Node

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")
var player_state = null

func enter(get_tilemap , tile_data):
	
	#going to add this to the player
	if player_state == 1 and tile_data == 0:
		
		#position of strike_box
		if Input.is_action_just_pressed("ui_accept"):
			
			get_tilemap.set_cells_terrain_connect(1,[player_strike_box.box_pos(get_tilemap)],0,0,false)
			
	
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state
	
	
