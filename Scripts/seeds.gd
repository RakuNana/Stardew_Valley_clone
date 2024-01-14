extends Button
class_name seedlings

#Add a check to seed pos, that keeps it in the soil tile

@onready var get_planted_seed = preload("res://seeds/planted.tscn")
@export var get_seed_data = Resource

var can_pick_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	mouse_position()
	follow_mouse()
	#check_soil()
	#check if mouse is over tile
	
func follow_mouse():
	
	var mouse_pos = get_viewport().get_mouse_position()
	
	if Input.is_action_pressed("mouse_click") and can_pick_up:
		
		position = mouse_pos - Vector2(8,8)
		
	if Input.is_action_just_released("mouse_click"):
		
		can_pick_up = false
		
func check_soil():
	
	#needs to add a physics layer. in tileset menu
	var soil_bodies = get_node("Area2D").get_overlapping_bodies()
	
	for mound in soil_bodies:
		
		if mound.is_in_group("soil") and !can_pick_up:
			
			mound.change_tile(mouse_position(),self)
			print(get_seed_data.seed_name)
			
		#if !can_pick_up:
			#
			#mound.change_tile(mouse_position(),self)
			
			
func mouse_position():
	
	var m_pos = get_viewport().get_mouse_position()
	var coords = get_parent().get_node("soil").local_to_map(m_pos)
	
	return coords


func _on_mouse_entered():
	
	can_pick_up = true

func _on_mouse_exited():
	
	#I can still grab the seeds, fix this!
	if Input.is_action_just_released("mouse_click") and can_pick_up:
		
		can_pick_up = false
