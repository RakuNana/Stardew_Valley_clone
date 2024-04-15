extends CharacterBody2D

#should be in a globla script?
#var ate_crop = false

#var area_is_protected = false
var run_off_timer = 60
#var has_eaten_crops = false
var offset_pos = 8

#needs to trigger code if it doesn't collide with area2D

func _ready():
	
	self.position = Vector2(-2000,-2000)
	load_pest()
	
func load_pest():
	
	#run if no crops have been eaten today,probably should be in global
	#Stardew has code run a few times, when threshold is met, code stops running
	var all_crops = get_tree().get_nodes_in_group("crop")
	var num_of_crops = all_crops.size()
	
	var get_crop_to_eat = randi_range(0,num_of_crops)
	
	#checks if we have planted crops. Then checks is there's a scarecrow. if false, eat crop
	if num_of_crops > 0 and !all_crops[get_crop_to_eat - 1].get_parent().check_for_scarecrow():
		
		self.position.x = all_crops[get_crop_to_eat - 1].get_parent().position.x - offset_pos
		self.position.y = all_crops[get_crop_to_eat - 1].get_parent().position.y - offset_pos
		
		all_crops[get_crop_to_eat - 1].get_parent().eaten()
		
		
func _process(_delta):
	
	run_off_timer -= 1
	
	if run_off_timer<= 0:
		
		queue_free()
		
func test():
	
	print("hello")

