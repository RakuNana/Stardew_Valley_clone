extends Node

enum sprinkler_states {PLACEMENT,WATERING, OFF}

var all_state_list = [sprinkler_states.PLACEMENT,
						sprinkler_states.WATERING,
						sprinkler_states.OFF,]
						
var current_state = null
var prev_state = null

var has_been_set = false

func _ready():
	
	if current_state == null:
		
		current_state = all_state_list[0]
		
	#print(current_state)
	
	
func _process(_delta):
	
	get_current_state()
	get_child(current_state).get_current_state(current_state)
	
	if Input.is_action_just_pressed("ui_accept"):
		
		has_been_set = true
		
func move_sprinkler():
	
	if has_been_set == false:
	
		var mouse_pos = get_viewport().get_mouse_position()
		
		get_parent().position.x = snapped(mouse_pos.x,16) - 8
		get_parent().position.y = snapped(mouse_pos.y,16) - 8
	
	
func change_sprinkler_state():
	
	if current_state < all_state_list.size() - 1:
		
		prev_state = current_state
		current_state = all_state_list[prev_state] + 1
		
	else:
		
		current_state = all_state_list[0]
		
		
func _input(event):
	
	if event.is_action_pressed("ui_right"):
		
		current_state = 1
		
		
	if event.is_action_pressed("ui_left"):
		
		current_state = 0
	
	
func get_current_state():
	
	return current_state
