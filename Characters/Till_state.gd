extends State

@export var water_state : State

#@export var plant_state : State


func Entered():
	#super()
	
	print("I am tilling")
	
	
func _input(event):
	
	if event.is_action_pressed("ui_end"):
		
		exit_state()
	#return needs to be outside of if statement, or two return statements 
		return water_state
		
	return null

func exit_state():
	
	print("I have exited!")
	
	
func Update():
	
	print("till fool")
	
func _process(_delta):
	
	pass
	
