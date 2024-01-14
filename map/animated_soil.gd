extends TileMap

#dig based on combo? if soil and water, watered tile, else dry tile?

@onready var get_planted_seed = preload("res://seeds/planted.tscn")
@onready var player_strike_box = get_parent().get_node("Coletta/strike_box")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	add_to_group("soil")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func change_tile(seed_pos,seed_obj):
	
	var m_pos = get_viewport().get_mouse_position()
	
	#can work with get_layer_name(layer) also
	
	#if get_cell_atlas_coords(0,seed_pos == Vector2i(1,1):
	#if get_cell_source_id(1,seed_pos) == 0:
		
	set_cell(1,seed_pos,3,Vector2(1,0))
	
	var load_seeds = get_planted_seed.instantiate()
	get_node("all_plants").add_child(load_seeds)
	
	load_seeds.position = map_to_local(local_to_map(m_pos))
	seed_obj.queue_free()
			
