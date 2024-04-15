extends TileMap

#go through tile map with a for loop?
@onready var player_strike_box = get_parent().get_node("Coletta/strike_box")

func _ready():
	pass
	#var soil_tiles = get_used_cells(0)
	#print(soil_tiles)
	#
	#print(map_to_local(soil_tiles[0]))
	#
	#print(get_cell_atlas_coords(0,soil_tiles[0]))
	
	
func _input(event):
	
	if event.is_action_pressed("ui_accept"):
		
		set_cells_terrain_connect(0,[player_strike_box.box_position(self)],0,0,false)
		print(get_cell_atlas_coords(0,player_strike_box.box_position(self)))
