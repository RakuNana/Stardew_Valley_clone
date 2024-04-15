extends TextureRect

var can_follow = true
@export var get_data : Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	
	self.texture = get_data.seed_image

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var m_pos = get_viewport().get_mouse_position()
	#this isn't working, needs a to be instanced
	if can_follow:
		
		self.position.x = m_pos.x - 8
		self.position.y = m_pos.y - 8
	
	if Input.is_action_just_pressed("ui_accept"):
		
		can_follow = false
		
func use_tile_data(tile_type,tilemap,pos):
		
		if tile_type == 1:
			
			can_follow = false
			self.texture = get_data.planted_image
			
		if !can_follow:
			
			self.position = tilemap.map_to_local(tilemap.local_to_map(self.position))
			
func check_soil_type(collided_tilemap, tile_pos):
	
	var check_tile_pos = collided_tilemap.get_coords_for_body_rid(tile_pos)
	
	for x in collided_tilemap.get_layers_count():
		
		var data_tile = collided_tilemap.get_cell_tile_data(x,check_tile_pos)
		
		if data_tile:
			
			var find_soil_type = data_tile.get_custom_data_by_layer_id(0)
			
			use_tile_data(find_soil_type, collided_tilemap,check_tile_pos)
			
func _on_gui_input(event):
	
	if event.is_action_pressed("mouse_click"):
		
		print(get_data.value)

func _on_area_2d_body_shape_entered(body_rid, body, _body_shape_index, _local_shape_index):
	
	check_soil_type(body,body_rid)
