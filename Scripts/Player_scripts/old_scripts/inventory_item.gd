extends CenterContainer

#This is blocking the HL node, code a way for it to receive
signal use_item

var item_name = null
var item_icon = Texture

var hovering_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_child(0).get_child(1).text = str(Inventory.player_inventory[item_name]["amount"])
	
func _process(delta):
	#only checks when opened
	if hovering_over and Input.is_action_just_pressed("ui_accept"):
		
		emit_signal("use_item")
	
func get_item_name(give_name):
	
	item_name = give_name
	
	return item_name
	

func _on_gui_input(event):
	
	if event.is_action_pressed("mouse_click"):
		
		emit_signal("use_item")


func _on_mouse_entered():
	
	hovering_over = true
	get_parent().get_node("HL").show()

func _on_mouse_exited():
	
	hovering_over = false
	get_parent().get_node("HL").hide()


func _on_texture_rect_pressed():
	
	print("item_pressed")
