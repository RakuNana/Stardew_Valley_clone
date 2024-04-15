extends Sprite2D

#probably better as a resource

#What obj are we placing in our inventory
@export var plant_name : String
#How many days was it watered before it matured?
@export var watering_needs : int 
#How long does this plant need to enter its next stage of life
@export var days_to_change_stage  : int

#Will use this to compare watering needs
var days_watered = 0
#Will use to tell if plant has reached maturity
var days_planted = 0

#stops plant growth
var maturity_reached = false
#stops plant from recieving anymore bonuses once matured
var results_calculated = false

#Timer for when the plant will enter its next stage/sprite
var days_till_to_next_stage = 0
#Used to change to next sprite
var stages_of_growth = 0

var watered_soil = [2,4]

var withered = false
var watered = false

var reward_name = ""

#used to transfer the tile data, so it can be used elsewhere 
var check_planted_soil = null

var health = 5
var max_health = 100


var is_protected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("Area2D").add_to_group("crop")
	
	#Get the amount of plant frames
	#print(get_hframes())
	
func plus_day():
	
	#Keeps track of how many days the seeds have been planted
	days_planted += 1
	
	#Tracks how long it's been since the seeds have aged
	days_till_to_next_stage += 1
	
	if watered_soil.has(check_planted_soil):
		
		days_watered += 1
		watered = true
		
	else:
		
		watered = false
		
	age_plant()
	check_plant_results()
		
func check_plant_results():
	
	if maturity_reached and !results_calculated:
		
		#So this only triggers once
		results_calculated = true
		
		if days_watered >= watering_needs:
			
			#Do more stuff
			print("water needs met")
			print("Good reward")
			reward_name = "good_"
			
		else:
			print("water needs not met")
			print("No reward")
	
func age_plant():
	
	#activates the stage/age timer, then resets
	if days_till_to_next_stage == days_to_change_stage:
		
		#affects growth rate when watered
		if watered_soil.has(check_planted_soil):
			
			stages_of_growth += 1
			
		else:
			
			stages_of_growth += .5
			
		#Resets timer for plants life stages
		days_till_to_next_stage = 0
		
		if stages_of_growth < get_hframes():
			set_frame(stages_of_growth)
			
		else:
			
			maturity_reached = true
			
			
func eaten():
	
	queue_free()
	
func harvest():
	
	if maturity_reached:
		
		#create a new image and object for each reward?
		#Inventory.player_inventory[plant_name]["value"] = Inventory.player_inventory[plant_name]["value"] + reward
		Inventory.player_inventory[reward_name+plant_name]["amount"] += 1
		queue_free()
			
			
func check_soil_planted_in(tilemap):
	
	#going to use this for plant health
	
	var calc_pos = tilemap.local_to_map(self.position)
	
	var data_tile = tilemap.get_cell_tile_data(1,calc_pos)
	
	if data_tile:
		
		var find_soil_type = data_tile.get_custom_data_by_layer_id(0)
		
		check_planted_soil = find_soil_type
	
func _on_area_2d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	
	check_soil_planted_in(body)
	
func _on_area_2d_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	
	check_soil_planted_in(body)
	
func check_for_scarecrow():
	
	return is_protected
	
func _on_area_2d_area_entered(area):
	
	#emitt signal instead? Otherwise ecah crop needs a signal added
	
	#don't forget about layers, layer 4 is for harvest
	#signals need to be added to each crop!
	#scarecrow is present
	
	if area.is_in_group("scared_crow"):
		print("I'm safe")
		is_protected = true

func _on_area_2d_area_exited(area):
	
	#no scarecrow around,In case scarecrow is ever removed or destroyed
	if area.is_in_group("scared_crow"):
		print("I'm in danger")
		is_protected = false
