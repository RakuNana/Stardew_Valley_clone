extends Sprite2D


func _ready():
	
	#adds area2d to a group, crops will look for this group on collision
	get_node("protected_area/Area2D").add_to_group("scared_crow")
		
		
