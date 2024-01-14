extends CharacterBody2D

var movement = Vector2.ZERO
var speed = 3000

func _process(delta):
	
	player_movement()
	
	velocity = movement.normalized() * speed * delta
	move_and_slide()

func player_movement():
	
	var LEFT = Input.is_action_pressed("left")
	var RIGHT = Input.is_action_pressed("right")
	var DOWN = Input.is_action_pressed("down")
	var UP = Input.is_action_pressed("up")
	
	movement.x = -int(LEFT) + int(RIGHT)
	movement.y = -int(UP) + int(DOWN)
	
	if movement:
		
		get_node("anim").check_direction(true)
		velocity.x = movement.x * speed
		velocity.y = movement.y * speed
		
		
	else:
		
		get_node("anim").check_direction(false)
		velocity = Vector2.ZERO
