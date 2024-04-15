extends CenterContainer

#needs a way for drag and drop
signal use_item

var item_name
var is_hovered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("Item_button/Label").text =  str(Inventory.player_inventory[item_name]["amount"])
	get_node("Item_button/HL").hide()

func _process(_delta):
	
	#removed the accept pressed
	if is_hovered:
		
		emit_signal("use_item")
		

func get_item_name(give_name):
	
	item_name = give_name
	
	return item_name

func _on_texture_rect_mouse_entered():
	
	get_node("Item_button/HL").show()

func _on_texture_rect_mouse_exited():
	
	get_node("Item_button/HL").hide()


func _on_item_button_focus_entered():
	
	is_hovered = true
	get_node("Item_button/HL").show()

func _on_item_button_focus_exited():
	
	is_hovered = false
	get_node("Item_button/HL").hide()

func _on_item_button_button_down():
	
	get_node("Item_button/Label").text =  str(Inventory.player_inventory[item_name]["amount"])
	emit_signal("use_item")

