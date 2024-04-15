extends Node

signal remove_mouse_icon
signal remove_held_item
signal changed_state
#ints from the custom tile data
var plantable_soil = [1,2,3,4]

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")

var player_state = null
var load_seeds = null
var current_amount = null
var transfer_current_seed = null
var has_seeds = false

func _ready():
	
	connect("changed_state", state_has_changed)

func enter(get_tilemap , tile_data):
	
	if transfer_current_seed != null:
		
		if Inventory.player_inventory[transfer_current_seed]["amount"] <= 0:
			
			emit_signal("remove_mouse_icon")
			
		if Input.is_action_just_pressed("delete"):
			
			# P key
			transfer_current_seed = null
			emit_signal("remove_mouse_icon")
			
		plant_in_soil(get_tilemap , tile_data)
		plant_with_mouse(get_tilemap)
		
		
func plant_in_soil(get_tilemap , tile_data):
	
	if player_state == 3 and !has_seeds:
		
		#checks if tiledata is in list. If so, it can be seeded!
		if plantable_soil.has(tile_data):
		
			#position of strike_box
			if Input.is_action_just_pressed("ui_accept") and Inventory.player_inventory[transfer_current_seed]["amount"] > 0 :
				
				#Needs fstring
				var new_seeds = load_seeds.instantiate()
				#remeber to add child for other objects!
				get_tilemap.get_node("all_plants").add_child(new_seeds)
				
				Inventory.player_inventory[transfer_current_seed]["amount"] -= 1
				#This is loading in the seeds that follow mouse_pos
				#Use another resource?
				#Create seed obj folder instead? sort through that?
				new_seeds.position = get_tilemap.map_to_local(player_strike_box.box_pos(get_tilemap))
	
func plant_with_mouse(get_tilemap):
	
	if Input.is_action_just_pressed("mouse_click") and Inventory.player_inventory[transfer_current_seed]["amount"] > 0 :
		
		var m_pos = get_viewport().get_mouse_position()
		var calc_pos = get_tilemap.local_to_map(m_pos)
		var data_tile = get_tilemap.get_cell_tile_data(1,calc_pos)
		
		if data_tile:
			
			var find_soil_type = data_tile.get_custom_data_by_layer_id(0)
			
			#checks if the soil has seeds in it and if the soil  has been tilled
			if !has_seeds and plantable_soil.has(find_soil_type):
				
				#Needs fstring
				var new_seeds = load_seeds.instantiate()
				get_tilemap.get_node("all_plants").add_child(new_seeds)
				Inventory.player_inventory[transfer_current_seed]["amount"] -= 1
				
				new_seeds.position = get_tilemap.map_to_local(get_tilemap.local_to_map(m_pos))
				
func current_seed_in_hands(current_seed):
	
	var find_seed = "res://inventory_objects/{seed_to_plant}.tscn"
	var gotten_seed = find_seed.format({"seed_to_plant" : current_seed})
	
	#gives me the string name to pass on
	transfer_current_seed = current_seed
	
	if Inventory.player_inventory[current_seed]["amount"] > 0 :
		
		var new_seed = gotten_seed
		
		#gives me the obj to pass on and instance
		load_seeds = load(new_seed)
		
		return current_seed
	
func get_mouse_icon(get_icon):
	
	#needs it's own folder
	
	var icon_folder_path = "res://Sprites/Menus/Inventory_item_sprites/{icon}.png"
	var got_icon = icon_folder_path.format({"icon" : get_icon})
	
	var get_mouse_icon_scene = load("res://inventory_objects/mouse_icon.tscn")
	var load_mouse_icon = get_mouse_icon_scene.instantiate()
	
	#adds child to statemachine!
	add_child(load_mouse_icon)
	
	#changes mouse icon
	load_mouse_icon.change_icon(got_icon)
	
func check_if_seeds(soil_has_seeds):
	
	#called in strike_box script
	has_seeds = soil_has_seeds
	
	return has_seeds
	
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state

func state_has_changed():
	
	transfer_current_seed = null
	emit_signal("remove_mouse_icon")
