extends Node

#prevent fert from being added to seeded soil
#fix tile , strike box bug
#set_cell needs to be change to set_terrain
#add pest

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")
var player_state = null

#added
var has_seeds = false

func enter(get_tilemap , tile_data):
	
	#going to add this to the player
	if player_state == 4 and player_strike_box.check_if_seeded() and !has_seeds: 
		
		#dry soil
		if tile_data == 1:
		
			#position of strike_box
			if Input.is_action_just_pressed("ui_accept"):
				
				get_tilemap.set_cells_terrain_connect(1,[player_strike_box.box_pos(get_tilemap)],0,2,false)
				
		#watered soil
		if tile_data == 2:
		
			#position of strike_box
			if Input.is_action_just_pressed("ui_accept"):
				
				get_tilemap.set_cells_terrain_connect(1,[player_strike_box.box_pos(get_tilemap)],0,3,false)
			
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state
	
	
func check_if_seeds(soil_has_seeds):
	#added
	has_seeds = soil_has_seeds
	
	return has_seeds
	

