extends TextureRect

var offset = Vector2(8,8)

func _ready():
	
	get_parent().connect("remove_mouse_icon",delete_mouse_icon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var m_pos = get_viewport().get_mouse_position()
	
	self.position = m_pos - offset
	
func change_icon(get_icon):
	
	texture = load(get_icon)
	
	return texture
	
func delete_mouse_icon():
	
	queue_free()
