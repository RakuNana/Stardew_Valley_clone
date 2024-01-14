extends State

@export var till_state : State


func Entered():
	#super()
	
	print("I am watering")
	
	
func _input(event):
	
	if event.is_action_pressed("ui_undo"):
		
		exit_state()
	#return needs to be outside of if statement, or two return statements 
		return till_state
		
	return null

func exit_state():
	
	print("I have exited!")
	
	
func Update():
	
	print("water fool")
	
func _process(_delta):
	
	pass
	

