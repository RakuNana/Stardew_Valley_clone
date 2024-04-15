extends Node

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")
var player_state = null

func enter(get_tilemap ,tile_data):
	
	#bug Player needs to left tile and come back to change properly
	
	#If in water state and soil is dry and no fert
	if player_state == 2 and tile_data == 1:
		
		if Input.is_action_just_pressed("ui_accept"):
			
			get_tilemap.set_cells_terrain_connect(1,[player_strike_box.box_pos(get_tilemap)],0,1,false)
	#If in water state and soil is dry and has fert
	if player_state == 2 and tile_data == 3:
	
		if Input.is_action_just_pressed("ui_accept"):
			
			get_tilemap.set_cells_terrain_connect(1,[player_strike_box.box_pos(get_tilemap)],0,3,false)
			
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state
	
	

