extends Node
class_name State_Machine

#var starting_state = null
var current_state = null
var prev_state = null

enum all_states { NONE , TILL , WATER, PLANT, FERT}

var states_list = [ all_states.NONE, 
					all_states.TILL , 
					all_states.WATER , 
					all_states.PLANT,
					all_states.FERT
					]
					
#Used to display current state on HUD
var current_state_names = ["NONE", "TILL" , "WATER", "PLANT" , "FERT"]


func _ready():
	
	if current_state == null:
		
		current_state = states_list[0]
		
func _process(_delta):
	
	get_current_state()
	
	#Changes to the next state node and calls get_current_state func
	get_child(current_state).get_current_state(current_state)
	
func get_next_state():
	
	if current_state < states_list.size() - 1:
		
		prev_state = current_state
		current_state = states_list[prev_state] + 1
		
	else:
		
		current_state = states_list[0]
		
	#print(get_child(current_state))
		
		
func get_prev_state():
	
	if current_state != 0:
		
		prev_state = current_state
		current_state = states_list[prev_state] - 1
		
	else:
		
		current_state = states_list[4]
		
		
	
func _input(event):
	
	#Just for testing State machine
	if event.is_action_pressed("ui_end"):
		
		get_next_state()
		
	if event.is_action_pressed("ui_home"):
		
		get_prev_state()
		
	#Will swap for HUD buttons
	if event.is_action_pressed("ui_down"):
		
		enter_till_mode()
		
	if event.is_action_pressed("ui_up"):
		
		enter_water_mode()
		
func enter_till_mode():
	
	#Because these are hot keyed, They need a func to call them
	current_state = 1
	#print(get_child(current_state))
	
func enter_water_mode():
	
	#Because these are hot keyed, They need a func to call them
	current_state = 2
	#print(get_child(current_state))
	
func get_current_state():
	
	#Used for nodes in the state machine to trigger state change
	#print(player_state)
	return current_state
	
	
func get_current_state_name():
	
	#Used for the HUD, displays current state
	return current_state_names[current_state]
	
	
