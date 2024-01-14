extends TileMap

var player_strike_box = null
var all_tiles = {"dry": [Vector2(5,5)] , "watered" : [Vector2(5,6)]}
var revert_tile = []

const ALL_SOIL_TILES = ["res://Sprites/Overworld/over_world_tilesets/ground_tiles2.png",#normal soil
						"res://Sprites/Overworld/over_world_tilesets/ground_no_watered_fert.png",#no water, fert
						"res://Sprites/Overworld/over_world_tilesets/ground_watered_fert.png",#watered and fert
						"res://Sprites/Overworld/over_world_tilesets/ground_watered_no_fert.png"#waterd , no fert
						]

var soil_type = 0

var dig_mode = false

func _input(event):
	
	if event.is_action_pressed("ui_down"):
		
		dig_mode = true
		
	if event.is_action_pressed("ui_up"):
		
		dig_mode = false
		
	#going to add this to the player
	if dig_mode:
			
		#can be used to paint tilemaps but, needs to be called every frame!
		if event.is_action_pressed("mouse_click"):
			
			set_cell(1,Vector2(0,0),0,Vector2(1,1))
			
			
func has_been_watered():
	
	if Input.is_action_just_pressed("water"):
		soil_type = (soil_type + 1)%4
		var tex = load(ALL_SOIL_TILES[soil_type])
		self.tile_set.get_source(3).texture = tex
		
		
		
		
func check_tiles():
	
	if Input.is_action_just_pressed("ui_left"):
		
		print("watered", " ", all_tiles["watered"])
		print("dry"," ", all_tiles["dry"])
	
	#bug: if watertile is by itself, dosen't connect
	
	#will use to check every tile on the map, then change them accordingly
	for x in all_tiles["dry"]:
		
		set_cell(1,x,0,Vector2i(1,1))
		#set_cells_terrain_connect(1,[x],0,0,false)
		
	for x in all_tiles["watered"]:
		
		set_cell(1,x,1,Vector2i(1,1))
		#set_cells_terrain_connect(1,[x],0,1,false)
		
		
	
	for x in get_used_cells(1):
		
		if !all_tiles["dry"].has(x):
			all_tiles["dry"].append(x)
			
			
func watering():
	
	if all_tiles["dry"].has(player_strike_box.box_pos(self)):
		
		all_tiles["watered"].append(player_strike_box.box_pos(self))
		all_tiles["dry"].erase(player_strike_box.box_pos(self))
		
		
		
		
		
#func change_tile(seed_pos,seed_obj):
	##can delete?
	#var m_pos = get_viewport().get_mouse_position()
	#
	#set_cell(1,seed_pos,3,Vector2(1,0))
	#
	#var load_seeds = get_planted_seed.instantiate()
	#get_node("all_plants").add_child(load_seeds)
	#
	#load_seeds.position = map_to_local(local_to_map(m_pos))
	#seed_obj.queue_free()
