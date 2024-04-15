extends Node

@onready var call_inventory_screen = preload("res://UI/Inventory_screen.tscn")

var player_state = null
var has_been_called = false

func enter(_get_tilemap , _tile_data):
	
	#needs to check tile if placeable area
	pass
	
func _process(_delta):
	
	#dosen't work in input func
	if Input.is_action_just_pressed("ui_page_down") and !has_been_called:
		
		has_been_called = true
		var new_invo = call_inventory_screen.instantiate()
		new_invo.connect("invo_closed",check_invo_status)
		add_child(new_invo)
		get_tree().paused = true
		

func get_current_state(current_state):
	
	player_state = current_state
	#print(player_state)
	return player_state
	
func check_invo_status():
	
	has_been_called = false
	
	return has_been_called
	
