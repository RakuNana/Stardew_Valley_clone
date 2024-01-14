extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_shape_entered(body_rid, body, _body_shape_index, _local_shape_index):
	
	if body is TileMap:
		
		print(body.check_soil_type(body,body_rid))
		
		if body.check_soil_type(body,body_rid) == 2:
			body.change_tile(body,self)
			print("watered!")
			
		else:
			
			print("dry soil")
		#print(body,body_rid)
