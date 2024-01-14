extends Node

#ints from the custom tile data
var plantable_soil = [1,2,3,4]
#Needs to be able to change the plant based on seed type!

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")
@onready var get_planted_seed = preload("res://seeds/planted.tscn")
var player_state = null

func enter(get_tilemap , tile_data):
	
	if player_state == 3:
		
		#checks if tiledata is in list. If so, it can be seeded!
		if plantable_soil.has(tile_data):
		
			#position of strike_box
			if Input.is_action_just_pressed("ui_accept"):
				
				#Needs to change depending on tile type!
				#get_tilemap.set_cell(1,player_strike_box.box_pos(get_tilemap),3,Vector2(1,0))
				var load_seeds = get_planted_seed.instantiate()
				get_tilemap.get_node("all_plants").add_child(load_seeds)
			
				load_seeds.position = get_tilemap.map_to_local(player_strike_box.box_pos(get_tilemap))
			
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state
	
	
