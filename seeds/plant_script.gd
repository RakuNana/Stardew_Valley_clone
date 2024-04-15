extends Sprite2D

var health = 10
var current_age = 0 #in days
var is_riped = false #plant can be harvested
var is_withered = false #Plant has died


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#added
	#adding the area2d to a group. Used for col.
	get_node("plant_area").add_to_group("plant_area")
	print("I am plant")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func water_fert(tile_type):
	
	#Have trigger at end of day?
	if tile_type == 4:
		
		health = 20
		print(health)
		
	if tile_type == 2:
		
		health = 10
		print(health)
		
		
	
func received_soil(tilemap):
	
	var calc_pos = tilemap.local_to_map(self.position)
	
	var data_tile = tilemap.get_cell_tile_data(1,calc_pos)
	
	if data_tile:
		
		var find_soil_type = data_tile.get_custom_data_by_layer_id(0)
		print(find_soil_type)
		
		water_fert(find_soil_type)

func _on_plant_area_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	
	#Player won't trigger this, different layers
	
	#Doesn't trigger when fert and watered?
	received_soil(body)

func _on_plant_area_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	
	#gets tile data
	received_soil(body)
