extends TextureRect

#needs a way to use spacebar to select item!

signal invo_closed

@onready var get_item_box = preload("res://objects/inventory_item.tscn")
@onready var get_slot = preload("res://UI/Slot_container.tscn")

var iteration = 0
var slot_mount = 5
var box_selected_list = [0,1,2,3,4]

var current_slot = 0
var prev_slot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_items_in_inventory()
	get_node("panel_group").get_child(box_selected_list[current_slot]).get_child(1).show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#dosen't work in input func
	if Input.is_action_just_pressed("ui_page_down"):
		
		get_tree().paused = false
		emit_signal("invo_closed")
		queue_free()
		
	if Input.is_action_just_pressed("ui_accept"):
		
		print(get_node("panel_group").get_child(current_slot).get_child(2).name)
		
func _input(event):
	
	if event.is_action_pressed("right"):
		
		get_next_slot()
		
	if event.is_action_pressed("left"):
		
		get_prev_slot()
		
func _on_quit_button_pressed():
	
	emit_signal("invo_closed")
	get_tree().paused = false
	queue_free()
	
func get_items_in_inventory():
	
	#creates slots
	for x in range(slot_mount):
		
		var new_slot = get_slot.instantiate()
		get_node("panel_group").add_child(new_slot)
	
	for y in Inventory.player_inventory.keys():
		
		#If we have an amount of 0, don't instance!
		if Inventory.player_inventory[y]["amount"] > 0:
			
			var new_item = get_item_box.instantiate()
			
			assign_icon(new_item.get_child(0).get_child(0),new_item.get_item_name(str(y)))
			new_item.connect("use_item",selected_item.bind(str(y)))
			
			#adds items to scene, but HL is part of children, place add_child elsewhere?
			get_node("panel_group").get_child(iteration).add_child(new_item)
			iteration += 1
			
func assign_icon(icon_instance,name_id_2):
	
	var name_2 = "res://Sprites/Menus/Inventory_item_sprites/{id}.png"
	var insert_name_2 = name_2.format({"id" : name_id_2})
	icon_instance.texture = load(insert_name_2)
	
func selected_item(obj_name):
	
	var find_obj = "res://inventory_objects/{obj}.tscn"
	var gotten_obj = find_obj.format({"obj" : obj_name})
	
	Inventory.player_inventory[obj_name]["amount"] -= 1
	
	var new_item = load(gotten_obj).instantiate()
	
	get_tree().get_current_scene().add_child(new_item)
	
	emit_signal("invo_closed")
	get_tree().paused = false
	queue_free()
	
func get_next_slot():
	
	if current_slot < box_selected_list.size() - 1:
		
		prev_slot = current_slot
		current_slot = box_selected_list[prev_slot] + 1
		
		#get next slot
		get_node("panel_group").get_child(box_selected_list[current_slot]).get_child(1).show()
		#previous slot HL hidden
		get_node("panel_group").get_child(box_selected_list[prev_slot]).get_child(1).hide()
		
	else:
		
		prev_slot = current_slot
		current_slot = 0
		get_node("panel_group").get_child(box_selected_list[current_slot]).get_child(1).show()
		get_node("panel_group").get_child(box_selected_list[prev_slot]).get_child(1).hide()
		
func get_prev_slot():
	
	if current_slot != 0:
		
		prev_slot = current_slot
		current_slot = box_selected_list[prev_slot] - 1
		
		#get next slot
		get_node("panel_group").get_child(box_selected_list[current_slot]).get_child(1).show()
		#previous slot HL hidden
		get_node("panel_group").get_child(box_selected_list[prev_slot]).get_child(1).hide()
		
	else:
		
		prev_slot = current_slot
		current_slot = 4
		get_node("panel_group").get_child(box_selected_list[current_slot]).get_child(1).show()
		get_node("panel_group").get_child(box_selected_list[prev_slot]).get_child(1).hide()
		
