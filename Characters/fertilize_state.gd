extends Node

#prevent fert from being added to seeded soil
#fix tile , strike box bug
#add sprinklers
#add pest

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")
var player_state = null

func enter(get_tilemap , tile_data):
	
	#going to add this to the player
	if player_state == 4 and player_strike_box.check_if_seeded(): 
		
		#dry soil
		if tile_data == 1:
		
			#position of strike_box
			if Input.is_action_just_pressed("ui_accept"):
				
				var current_tile_atlas = get_tilemap.get_cell_atlas_coords(1,player_strike_box.box_pos(get_tilemap))
				get_tilemap.set_cell(1,player_strike_box.box_pos(get_tilemap),2,current_tile_atlas)
				
		#watered soil
		if tile_data == 2:
		
			#position of strike_box
			if Input.is_action_just_pressed("ui_accept"):
				
				var current_tile_atlas = get_tilemap.get_cell_atlas_coords(1,player_strike_box.box_pos(get_tilemap))
				get_tilemap.set_cell(1,player_strike_box.box_pos(get_tilemap),5,current_tile_atlas)
			
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state
	
	

