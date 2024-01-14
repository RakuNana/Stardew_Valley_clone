extends RichTextLabel

@onready var player_state_machine = get_parent().get_parent().get_node("Statemachine")

func _process(_delta):
	
	text = player_state_machine.get_current_state_name()
