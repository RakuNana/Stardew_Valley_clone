extends MarginContainer

#use to remove mouse icon and state also?
signal change_current_slot
signal remove_mouse_icon

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("HL").hide()

func _on_slot_1_mouse_entered():
	
	get_node("HL").show()

func _on_slot_1_mouse_exited():
	
	get_node("HL").hide()

