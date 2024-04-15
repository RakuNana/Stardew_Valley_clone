extends Sprite2D

#use statemachine instead?

@export var get_seed_data = Resource
#add to a dict? Then add age?
var plant_hp = 5
var current_cycle = 0
var is_ripe = false

func _ready():
	
	set_frame(0)
	
func harvest_crop():
	
	if is_ripe:
		queue_free()
		
func crop_watered(riped_crop,was_watered):
	
	if !riped_crop:
	
		if was_watered:
			plant_hp += 1
			
		else :
			
			plant_hp -= 1
		
func age_day():
	#make global?
	current_cycle += 1

func get_current_cycle():
	
	if current_cycle < 5:
		
		set_frame(current_cycle)
		
	else:
		
		is_ripe = true
		set_frame(5)
	
	if current_cycle == 5:
		current_cycle = 5
		#needs to reset soil also!
		print("all_grown")
