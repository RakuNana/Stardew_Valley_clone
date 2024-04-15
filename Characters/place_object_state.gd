extends Node

signal remove_mouse_icon
signal remove_held_item
signal changed_state

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")

var player_state = null
var transfer_obj_data = null
var loaded_placeable_obj = null

func _ready():
	
	connect("changed_state", state_has_changed)

func enter(get_tilemap , _tile_data):
	
	if player_state == 6 and transfer_obj_data != null:
		
		place_on_ground(get_tilemap)
		place_with_mouse(get_tilemap)
	
	if transfer_obj_data != null:
		
		if Inventory.player_inventory[transfer_obj_data]["amount"] <= 0:
		
			emit_signal("remove_mouse_icon")
			
		if Input.is_action_just_pressed("delete"):
			
			# P key
			transfer_obj_data = null
			emit_signal("remove_mouse_icon")
	
func place_on_ground(passed_tilemap):
	
	if Inventory.player_inventory[transfer_obj_data]["amount"] > 0 and Input.is_action_just_pressed("ui_accept"):
		
		var new_obj = loaded_placeable_obj.instantiate()
		Inventory.player_inventory[transfer_obj_data]["amount"] -= 1
		
		add_child(new_obj)
		new_obj.position = passed_tilemap.map_to_local(player_strike_box.box_pos(passed_tilemap))

func place_with_mouse(passed_tilemap):
	
	var m_pos = get_viewport().get_mouse_position()
		
	if Inventory.player_inventory[transfer_obj_data]["amount"] > 0 and Input.is_action_just_pressed("mouse_click"):
		
		var new_obj = loaded_placeable_obj.instantiate()
		Inventory.player_inventory[transfer_obj_data]["amount"] -= 1
		
		add_child(new_obj)
		new_obj.position = passed_tilemap.map_to_local(passed_tilemap.local_to_map(m_pos))

func find_obj(passed_obj):
	
	var get_obj_path = "res://inventory_objects/{obj}.tscn"
	var load_obj = get_obj_path.format({"obj" : passed_obj})
	
	transfer_obj_data = passed_obj
	
	if Inventory.player_inventory[passed_obj]["amount"] > 0 :
		
		var new_obj = load_obj
		
		loaded_placeable_obj = load(new_obj)
		
		return load_obj
		
func get_mouse_icon(get_icon):
	
	#needs it's own folder
	
	var icon_folder_path = "res://Sprites/Menus/Inventory_item_sprites/{icon}.png"
	var got_icon = icon_folder_path.format({"icon" : get_icon})
	
	var get_mouse_icon_scene = load("res://inventory_objects/mouse_icon.tscn")
	var load_mouse_icon = get_mouse_icon_scene.instantiate()
	
	add_child(load_mouse_icon)
	
	#changes mouse icon
	load_mouse_icon.change_icon(got_icon)
	
func state_has_changed():
	
	transfer_obj_data = null
	emit_signal("remove_mouse_icon")
	
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state
