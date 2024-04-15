extends TileMap
class_name ground_tiles

#Tiles need to revert back to soil or grass!
#tiles that are already watered need to terrain

#@onready var load_sprinkler = preload("res://objects/SM_Sprinkler.tscn")
@onready var player_strike_box = get_parent().get_node("Coletta/strike_box")
@onready var get_player_statemachine = get_parent().get_node("Coletta/Statemachine")
@onready var get_pest = preload("res://Characters/Rabbit.tscn")


var check_seed_pos

#needs a default value!
var transfer_tile_data = 0 

#enums to change vars to ints!
#I can see which tiles are what, without going to the tileset
enum soil_types {GRASS = 0,
				DRY_SOIL = 1,
				WATERED_SOIL = 2,
				FERT_SOIL = 3,
				WATERED_FERT_SOIL = 4,
				PLANTED_SOIL = 5,
				TALL_GRASS = 6
}

#So I can call/use the vars inside the enum list
var tile_type_list = [soil_types.GRASS,
					soil_types.DRY_SOIL,
					soil_types.WATERED_SOIL,
					soil_types.FERT_SOIL,
					soil_types.WATERED_FERT_SOIL,
					soil_types.PLANTED_SOIL,
					soil_types.TALL_GRASS,
					]

func _ready():
	
	pass
		
func _process(_delta):
	
	hightlight_cell()
	find_current_state()
	
	if Input.is_action_just_pressed("spawn_pest"):
		#zero key
		#code currently runs on button press, should happen
		#automatically when crops are planted, 
		#should run more than once
		#Should keep track if a crop was eaten
		
		var spawn_pest = get_pest.instantiate()
		add_child(spawn_pest)
	
	if Input.is_action_just_pressed("ui_left"):
		
		dry_out_soil()
		
	if Input.is_action_just_pressed("end_of_day"):
		
		# T key 
		end_of_day()
	
func end_of_day():
	
	GetPlantedSeedsData.get_plant_data(get_node("all_plants"))
		
func find_current_state():
	
	#triggering state machine!
	var current_state = get_player_statemachine.get_current_state()
	get_player_statemachine.get_child(current_state).enter(self,tile_type_list[transfer_tile_data])
	
func dry_out_soil():
	
	#goes through layer 1 of tile map
	#and changes them all to terrain 1(dry soil)
	#bug gets rid of fert soil also, needs fix
	for all_tiles in get_used_cells(1):
		
		#print(all_tiles)
		set_cells_terrain_connect(1,[all_tiles],0,0,false)
		
		#set_cell(1,all_tiles)
		
func check_soil_type(collided_tilemap):
	
	#gets tile custom data
	#called on from seed script
	#strike_box script
	
	#this is getting all the tile data, needs to limit
	
	for x in collided_tilemap.get_layers_count():
		
		var data_tile = collided_tilemap.get_cell_tile_data(x,player_strike_box.box_pos(self))
		
		if data_tile:
			
			#var find_soil_type = data_tile.get_custom_data("soil_type")
			var find_soil_type = data_tile.get_custom_data_by_layer_id(0)
			
			#So I can use this data elsewhere!
			transfer_tile_data = find_soil_type
			
func hightlight_cell():
	
	var m_pos = get_viewport().get_mouse_position()
	
	#get_cell_atlas_coords(0,mouse_position())
	
	if get_cell_tile_data(1,mouse_position()):
		
		get_parent().get_node("HL").show()
		
	else:
		
		get_parent().get_node("HL").hide()
		
		
	get_parent().get_node("HL").position = map_to_local(local_to_map(m_pos))
	
func mouse_position():
	
	var m_pos = get_viewport().get_mouse_position()
	var coords = local_to_map(m_pos)
	
	return coords
	
	
