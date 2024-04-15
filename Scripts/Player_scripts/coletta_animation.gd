extends AnimatedSprite2D

@onready var player_node = get_parent()
@onready var anim_player = get_parent().get_node("anim_player")

var current_dir = "idle"

func _ready():
	pass
	anim_player.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	pass
	
	#pos doesn't change, due to offset
	#var test = get_parent().get_node("Marker2D").position.x
	
	#may move this elsewhere
	#get_parent().get_node("strike_box").snap_to_tiles()
			
func check_direction(is_moving,is_holding):
	
	if !is_moving and is_holding != 7:
		
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
			
		if Input.is_action_just_pressed("happy"):
			
			current_dir = "happy"
			play("celebrate")
			
func check_holding_direction(is_moving,is_holding):
	
	if !is_moving and is_holding == 7:
		
		#This is just a default for when the game first loads
		if current_dir == "idle":
			play("idle_holding_down")
			
			
		if current_dir == "up":
			play("idle_holding_up")
			
			
		if current_dir == "down":
			play("idle_holding_down")
			
			
		if current_dir == "left":
			play("idle_holding_left")
			
			
		if current_dir == "right":
			play("idle_holding_right")
			
func moving_animation(UP,DOWN,LEFT,RIGHT,is_holding):
	
	if is_holding != 7:
			
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
			
func holding_animations(UP,DOWN,LEFT,RIGHT,is_holding):
	
	if is_holding == 7:
		
		if UP:
		
			current_dir = "up"
			anim_player.play("up_strbx")
			play("holding_walk_up")
		
		
		elif DOWN:
			
			current_dir = "down"
			anim_player.play("down_strbx")
			play("holding_walk_down")
			
			
		elif LEFT:
			
			current_dir = "left"
			anim_player.play("left_strbx")
			play("holding_walk_left")
			
			
		elif RIGHT:
			
			current_dir = "right"
			anim_player.play("right_strbx")
			play("holding_walk_right")
			
