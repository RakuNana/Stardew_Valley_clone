extends Sprite2D

#added
var waterable_tiles = [1,2]
var fert_tiles = [3,4]
var has_been_set = false
var current_state = 0

func _ready():
	
	get_node("anim").play("sprinkler_off")
	print(get_parent())

func _process(_delta):
	
	#needs to be able to be called, and reverted
	#add a collision timer for turning on/off collision?
	var m_pos = get_viewport().get_mouse_position()
	
	check_sprinkler_state()
	
	if Input.is_action_just_pressed("ui_accept"):
		
		has_been_set = true
		
	move_sprinkler(m_pos)
	
func check_sprinkler_state():
	
	if current_state == 0:
		
		for x in get_node("mist").get_child_count(): 
			get_node("mist").get_child(x).get_child(0).disabled = true
			
	if current_state == 1:
		
		for x in get_node("mist").get_child_count(): 
			get_node("mist").get_child(x).get_child(0).disabled = false
			sprinkler_sprite_animation()
			
func _input(event):
	
	#turns sprinkler on and off
	#should be placed else where to trigger this
	if event.is_action_pressed("ui_right"):
		
		current_state = 1
		
	if event.is_action_pressed("ui_left"):
		
		current_state = 0
		
func move_sprinkler(nm_pos):
	
	if !has_been_set:
		
		self.position.x = snapped(nm_pos.x,16) - 8
		self.position.y = snapped(nm_pos.y,16) - 8
		
func sprinkler_sprite_animation():
	
	get_node("anim").play("sprinkler_on")
	
func water_soil(get_tilemap,tiledata,tile_pos):
	
	#needs to check if soil is fert or not
	if waterable_tiles.has(tiledata):
		
		get_tilemap.set_cells_terrain_connect(1,[tile_pos],0,1,false)
		
	if fert_tiles.has(tiledata):
		
		get_tilemap.set_cells_terrain_connect(1,[tile_pos],0,3,false)
	
#This is checked only once on enter/exit. won't update otherwise
func check_soil_type(collided_tilemap, tile_pos):
	
	var check_tile_pos = collided_tilemap.get_coords_for_body_rid(tile_pos)
	
	for x in collided_tilemap.get_layers_count():
		
		var data_tile = collided_tilemap.get_cell_tile_data(x,check_tile_pos)
		
		if data_tile:
			
			var find_soil_type = data_tile.get_custom_data_by_layer_id(0)
			
			water_soil(collided_tilemap,find_soil_type,check_tile_pos)
			
func _on_mist_area_body_shape_entered(body_rid, body, _body_shape_index, _local_shape_index):
	
	check_soil_type(body,body_rid)

func _on_mist_area_body_shape_exited(body_rid, body, _body_shape_index, _local_shape_index):
	
	check_soil_type(body,body_rid)

func _on_anim_animation_finished(anim_name):
	
	if anim_name == "sprinkler_on":
		
		current_state = 0
		get_node("anim").play("sprinkler_off")
