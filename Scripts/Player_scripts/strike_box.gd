extends Area2D

var can_fert = true

func _ready():
	pass
	#get_node("CollisionShape2D").disabled = true

func _process(_delta):
	pass
	get_crop()
	#snap_to_tiles()
	
	#if Input.is_action_just_pressed("happy"):
		#
		#get_node("CollisionShape2D").disabled = false

func check_if_seeded():
	
	return can_fert 
	
func get_crop():
	
	var crops = get_overlapping_areas()
	
	#change to harvest state?
	
	for ripe_crops in crops:
		
		if Input.is_action_just_pressed("ui_accept"):
			
			#might add this to player interact instead
			#print(ripe_crops.get_parent())
			ripe_crops.get_parent().harvest()
	
func box_pos(find_tiles):
	
	var coords = find_tiles.local_to_map(get_node("CollisionShape2D").global_position)
	
	return coords
	
func snap_to_tiles():
	
	#have four collision boxes, have disabled until
	#facing that direction, then enable ?
	#should still snap to grid
	
	#added
	self.position.x = snapped(get_parent().position.x,16) - get_parent().position.x 
	self.position.y = snapped(get_parent().position.y,16) - get_parent().position.y - 8 
	
func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	
	#Standard body_entered does not work!
	body.check_soil_type(body)
	
func _on_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	
	body.check_soil_type(body)
	
func _on_area_entered(area):
	
	#added
	#changes can_fert to true
	
	#area group should be the crop we planted.
	if area.is_in_group("plant_area"):
		
		get_parent().get_node("Statemachine/plant").check_if_seeds(true)
		get_parent().get_node("Statemachine/fertilize").check_if_seeds(true)

func _on_area_exited(area):
	
	#added
	#changes can_fert to false
	if area.is_in_group("plant_area"):
		
		get_parent().get_node("Statemachine/plant").check_if_seeds(false)
		get_parent().get_node("Statemachine/fertilize").check_if_seeds(false)
