extends CharacterBody2D

var movement = Vector2.ZERO
var speed = 3000
#Coletta has a Z index of 1, Ordering tab

func _ready():
	
	add_to_group("Player")

func _process(delta):
	
	player_movement()
	
	if Input.is_action_just_pressed("ui_right"):
		pass
		#Inventory.player_inventory["apple_seeds"]["amount"] += 1
		#print(Inventory.player_inventory["good_apples"])
	
	velocity = movement.normalized() * speed * delta
	move_and_slide()

func player_movement():
	
	var LEFT = Input.is_action_pressed("left")
	var RIGHT = Input.is_action_pressed("right")
	var DOWN = Input.is_action_pressed("down")
	var UP = Input.is_action_pressed("up")
	
	movement.x = -int(LEFT) + int(RIGHT)
	movement.y = -int(UP) + int(DOWN)
	
	var current_holding_state = get_node("Statemachine").get_current_state() 
	
	if movement:
		
		get_node("anim").check_direction(true,current_holding_state)
		get_node("anim").check_holding_direction(true,current_holding_state)
		get_node("anim").moving_animation(UP,DOWN,LEFT,RIGHT,current_holding_state)
		get_node("anim").holding_animations(UP,DOWN,LEFT,RIGHT,current_holding_state)
		
		velocity.x = movement.x * speed
		velocity.y = movement.y * speed
		
		
	else:
		
		get_node("anim").check_direction(false,current_holding_state)
		get_node("anim").check_holding_direction(false,current_holding_state)
		velocity = Vector2.ZERO
		
		
