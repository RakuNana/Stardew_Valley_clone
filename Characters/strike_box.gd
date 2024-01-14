extends Area2D

var can_fert = true

func _process(_delta):
	pass
	#test_pos()
	get_crop()

func test_pos():
	
	#can I snap strikebox to tiles?
	self.look_at(get_parent().position - Vector2(-1,0))
	position = position.snapped(Vector2.ONE * 16)
	position += Vector2.ONE * 16/2
	#self.position = get_parent().position - snapped(Vector2(16,16),Vector2(16,16))

func check_if_seeded():
	
	return can_fert 
	
func get_crop():
	
	var crops = get_overlapping_areas()
	
	#change to harvest state?
	
	for ripe_crops in crops:
		
		if Input.is_action_just_pressed("ui_accept"):
			
			#might add this to player interact instead
			print(ripe_crops.get_parent())
			ripe_crops.get_parent().harvest_crop()
			
func box_pos(find_tiles):
	
	var coords = find_tiles.local_to_map(get_node("CollisionShape2D").global_position)
	
	return coords


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	
	#Standard body_entered does not work!
	body.check_soil_type(body)
	
func _on_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	
	body.check_soil_type(body)
	

