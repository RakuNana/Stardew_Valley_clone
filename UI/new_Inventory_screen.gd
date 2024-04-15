extends CanvasLayer

signal invo_closed

@onready var items_to_grab = preload("res://objects/inventory_item.tscn")
@onready var get_slot = preload("res://UI/Slot_container.tscn")

var slot_amount = 5
var iteration = 0
#added
var has_items = false

var item_num_focus = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	create_slots()
	get_inventory_items()
	
	#print(get_parent().get_parent().get_node("plant").current_seed_in_hands("apple_seeds"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_page_down"):
		
		get_tree().paused = false
		emit_signal("invo_closed")
		queue_free()
	
	#grabs the inventory_items button from scene 
	if has_items:
		get_node("panel_group").get_child(item_num_focus).get_child(2).get_child(0).grab_focus()
		
func create_slots():
	
	#creates slots
	for x in range(slot_amount):
		
		var new_slot = get_slot.instantiate()
		get_node("panel_group").add_child(new_slot)
		
func _input(event):
	
	if event.is_action_pressed("ui_left") and !item_num_focus <= 0:
		
		item_num_focus -= 1
		
	if event.is_action_pressed("ui_right") and !item_num_focus >= iteration - 1:
		
		item_num_focus += 1
		
func get_inventory_items():
	
	for x in Inventory.player_inventory.keys():
		
		if Inventory.player_inventory[x]["amount"] > 0:
			
			has_items = true
			
			var new_item = items_to_grab.instantiate()
			
			new_item.connect("use_item", selected_item.bind(str(x)))
			
			#grabs the invo_icon(Invo_screen scene)
			
			assign_icon(new_item.get_child(0).get_child(0),new_item.get_item_name(str(x)))
			
			#adds item to slot
			get_node("panel_group").get_child(iteration).add_child(new_item)
			
			iteration += 1
			
			
func assign_icon(icon_instance,name_id_2):
	
	var name_2 = "res://Sprites/Menus/Inventory_item_sprites/{id}.png"
	var insert_name_2 = name_2.format({"id" : name_id_2})
	icon_instance.texture = load(insert_name_2)
	
func selected_item(obj_name):
	
	#Checks item id, id seed id change to plant state
	remove_prev_mouse_icon()
	
	if get_item_type(obj_name) == 0:
		
		get_parent().get_parent().get_node("place_object").find_obj(obj_name)
		get_parent().get_parent().get_node("place_object").get_mouse_icon(obj_name)
		get_parent().get_parent().change_to_placeable_state()
	
	
	if get_item_type(obj_name) == 1:
		
		#have inst sprite for item, have m_clicks in statemachine
		get_parent().get_parent().get_node("plant").current_seed_in_hands(obj_name)
		get_parent().get_parent().get_node("plant").get_mouse_icon(obj_name)
		
		get_parent().get_parent().change_to_plantstate()
		
		
		#added
	if get_item_type(obj_name) == 2:
		
		#gets item to be used from tscn file
		get_parent().get_parent().get_node("useables").find_obj(obj_name)
		get_parent().get_parent().change_to_useables()
		
	
func remove_prev_mouse_icon():
	
	#added new signals
	#emits a signal to remove sprites from the mouse
	get_parent().get_parent().get_node("plant").emit_signal("remove_mouse_icon")
	get_parent().get_parent().get_node("plant").emit_signal("remove_held_item")
	
	get_parent().get_parent().get_node("place_object").emit_signal("remove_mouse_icon")
	get_parent().get_parent().get_node("place_object").emit_signal("remove_held_item")


func get_item_type(recieved_item):
	
	var current_item_type = Inventory.player_inventory[recieved_item]["type"]
	
	return current_item_type
	

func _on_texture_button_button_down():
	
	emit_signal("invo_closed")
	get_tree().paused = false
	queue_free()
