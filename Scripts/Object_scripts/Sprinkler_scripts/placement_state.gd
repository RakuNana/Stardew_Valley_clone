extends Node


var active_state = null


func _process(_delta):
	
	if active_state == 0:
		
		get_parent().move_sprinkler()


func get_current_state(current_state):
	
	active_state = current_state
	
	return active_state
