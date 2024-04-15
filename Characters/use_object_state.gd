extends Node

signal remove_mouse_icon
signal remove_held_item
signal changed_state

@onready var player_strike_box = get_parent().get_parent().get_node("strike_box")

var player_state = null

var useable_obj_data = null
var loaded_placeable_obj = null
var held_item_sprite = null


func _ready():
	
	connect("changed_state", state_has_changed)
	connect("remove_held_item",deselect_items)
	
	get_parent().get_node("plant").connect("remove_held_item",deselect_items)
	get_parent().get_node("place_object").connect("remove_held_item",deselect_items)

func enter(_get_tilemap , _tile_data):
	
	#adding player_state keeps item usage from triggering during item selection
	if useable_obj_data != null and player_state == 7:
		
		use_item()
		
		if Inventory.player_inventory[useable_obj_data]["amount"] <= 0:
		
			emit_signal("remove_held_item")
			get_parent().enter_none_state()
			
		if Input.is_action_just_pressed("delete"):
			
			# P key
			useable_obj_data = null
			emit_signal("remove_held_item")
			

func find_obj(passed_obj):
	
	var get_useables_path = "res://inventory_objects/{obj}.tscn"
	var load_useables = get_useables_path.format({"obj" : passed_obj})
	
	useable_obj_data = passed_obj
	
	if Inventory.player_inventory[passed_obj]["amount"] > 0 :
		
		#gets data to load
		var new_useable = load_useables
		loaded_placeable_obj = load(new_useable)
		
		get_icon_overhead(passed_obj)
		
		return load_useables
		
func use_item():
	
	if Input.is_action_just_pressed("ui_accept") and Inventory.player_inventory[useable_obj_data]["amount"] > 0:
		
		print("used item")
		Inventory.player_inventory[useable_obj_data]["amount"] -= 1
		
func get_icon_overhead(get_icon):
	
	#needs it's own folder
	var icon_folder_path = "res://Sprites/Menus/Inventory_item_sprites/{icon}.png"
	var got_icon = icon_folder_path.format({"icon" : get_icon})
	
	var overhead_item = get_parent().get_parent().get_node("held_item")
	
	overhead_item.texture = load(got_icon)
	
	held_item_sprite = overhead_item
	
func deselect_items():
	
	useable_obj_data = null
	
	if held_item_sprite != null:
		held_item_sprite.texture = null
	
func state_has_changed():
	
	useable_obj_data = null
	emit_signal("remove_mouse_icon")
	
func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state

