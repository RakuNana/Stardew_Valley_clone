extends Sprite2D

#needs to have water sprite off
#Change to resource?
#Have states universal/reusable
#Some how get it to not change tiles til after it's set!
#disable collision til it's set??

@onready var call_water = get_node("Sprinkler_states/water_soil")

func _process(_delta):
	
	#needs to be able to be called, and reverted
	#add a collision timer for turning on/off collision?
	
	if get_node("Sprinkler_states").get_current_state() == 0:
		
		for x in get_node("Sprinkler_states").get_child_count() + 1: 
			get_node("mist").get_child(x).get_child(0).disabled = true
			
	if get_node("Sprinkler_states").get_current_state() == 1:
		
		for x in get_node("Sprinkler_states").get_child_count() + 1: 
			get_node("mist").get_child(x).get_child(0).disabled = false
	
#This is checked only once on enter/exit. won't update
func check_soil_type(collided_tilemap, tile_pos):
	
	var check_tile_pos = collided_tilemap.get_coords_for_body_rid(tile_pos)
	
	for x in collided_tilemap.get_layers_count():
		
		var data_tile = collided_tilemap.get_cell_tile_data(x,check_tile_pos)
		
		if data_tile:
			
			var find_soil_type = data_tile.get_custom_data_by_layer_id(0)
			
			call_water.water_soil(collided_tilemap,find_soil_type,check_tile_pos)
			
func _on_mist_area_body_shape_entered(body_rid, body, _body_shape_index, _local_shape_index):
	
	check_soil_type(body,body_rid)

func _on_mist_area_body_shape_exited(body_rid, body, _body_shape_index, _local_shape_index):
	
	check_soil_type(body,body_rid)
