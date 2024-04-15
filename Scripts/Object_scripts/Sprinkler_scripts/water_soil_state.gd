extends Node

var active_state = null
var waterable_tiles = [1,2,3,4]
var fert_tiles = [3,4]
@onready var get_watering_col = get_parent().get_parent().get_node("mist/mist_area/mist_pos")

func water_soil(get_tilemap,tiledata,tile_pos):
	
	#needs to check if soil is fert or not
	if waterable_tiles.has(tiledata):
		
		get_tilemap.set_cells_terrain_connect(1,[tile_pos],0,1,false)
		
	if fert_tiles.has(tiledata):
		
		get_tilemap.set_cells_terrain_connect(1,[tile_pos],0,3,false)

func get_current_state(current_state):
	
	active_state = current_state
	
	return active_state
