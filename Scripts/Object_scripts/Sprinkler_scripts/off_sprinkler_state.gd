extends Node

var active_state = null
var waterable_tiles = [1,2,3,4]

func water_soil(get_tilemap,tiledata):
	
	if active_state == 1:
		
		if waterable_tiles.has(tiledata):
			
			get_tilemap.set_cells_terrain_connect(1,[water_pos(get_tilemap)],0,1,false)

func water_pos(get_tilemap):
	
	var coords = get_tilemap.local_to_map(get_node("mist/mist_L/Area2D/CollisionShape2D").global_position)
	
	return coords


func get_current_state(current_state):
	
	active_state = current_state
	
	return active_state
