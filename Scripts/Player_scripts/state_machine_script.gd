extends Node
class_name State_Machine

#var starting_state = null
var current_state = null
var prev_state = null

enum all_states { NONE , TILL , WATER, PLANT, FERT, INVENTORY,PLACE_OBJ,USEABLES}

var states_list = [ all_states.NONE, 
					all_states.TILL , 
					all_states.WATER , 
					all_states.PLANT,
					all_states.FERT,
					all_states.INVENTORY,
					all_states.PLACE_OBJ,
					all_states.USEABLES,
					]
					
#Used to display current state on HUD
var current_state_names = ["NONE", "TILL" , "WATER", "PLANT" , "FERT", "INVO","PL_OBJ","USEABLES"]


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
		
		current_state = states_list[7]
		
func _input(event):
	
	#Just for testing State machine
	if event.is_action_pressed("ui_end"):
		
		get_next_state()
		
	if event.is_action_pressed("ui_home"):
		
		get_prev_state()
		
	#Will swap for HUD buttons
	if event.is_action_pressed("ui_down"):
		
		enter_till_mode()
		
		#trigger with a signal on_state_change?
		
		clear_plant_place_states()
		
	if event.is_action_pressed("ui_up"):
		
		enter_water_mode()
		
		clear_plant_place_states()
		
func enter_none_state():
	
	current_state = 0
		
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
	
func change_to_plantstate():
	#added
	current_state = 3
	
func change_to_placeable_state():
	
	#added
	current_state = 6
	
func change_to_useables():
	
	#added
	current_state = 7
	
func clear_plant_place_states():
	
	#added
	get_node("plant").emit_signal("changed_state")
	get_node("place_object").emit_signal("changed_state")
	get_node("useables").emit_signal("changed_state")
	
func get_current_state_name():
	
	#Used for the HUD, displays current state
	return current_state_names[current_state]
	
	
