extends AnimatedSprite2D


@onready var player_node = get_parent()
@onready var anim_player = get_parent().get_node("anim_player")
var current_dir = "idle"

func _ready():
	
	anim_player.play("down_strbx")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	animation_loop()

func check_direction(is_moving):
	
	if !is_moving:
		
		#This is just a default for when the game first loads
		if current_dir == "idle":
			play("idle_down")
			
			
		if current_dir == "up":
			play("idle_up")
			
			
		if current_dir == "down":
			play("idle_down")
			
			
		if current_dir == "left":
			play("idle_left")
			
			
		if current_dir == "right":
			play("idle_right")
			
		if current_dir == "happy":
			
			play("celebrate")
		

func animation_loop():
	
	#dry
	var UP = Input.is_action_pressed("up")
	var DOWN = Input.is_action_pressed("down")
	var LEFT = Input.is_action_pressed("left")
	var RIGHT = Input.is_action_pressed("right")
	var HAPPY = Input.is_action_just_pressed("happy")
	
	
	if HAPPY:
		
		current_dir = "happy"
		
	
	if UP:
		
		current_dir = "up"
		anim_player.play("up_strbx")
		play("up_walk")
		
		
	elif DOWN:
		
		current_dir = "down"
		anim_player.play("down_strbx")
		play("down_walk")
		
		
	elif LEFT:
		
		current_dir = "left"
		anim_player.play("left_strbx")
		play("left_walk")
		
		
	elif RIGHT:
		
		current_dir = "right"
		anim_player.play("right_strbx")
		play("right_walk")
		
		
