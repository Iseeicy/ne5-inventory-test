extends AspectRatioContainer
class_name DebugItemUIDisplay

#
#	Private Variables
#

var _current_item: ItemInstance = null
var _empty_texture: Texture2D = preload("res://items/empty.png")

#
#	Public Functions
#

func show_item(item: ItemInstance) -> void:
	clear_item()
	if item == null: return
	
	_current_item = item
	
	# Set control visibility
	$Label.visible = item != null
	
	# Show the item's icon
	$MarginContainer/TextureRect.texture = item.get_descriptor().preview_icon
	if $MarginContainer/TextureRect.texture == null:
		$MarginContainer/TextureRect.texture = _empty_texture
	
	# Show the items stack size now, and whenver it changes
	_on_item_stack_size_changed(item.get_stack_size())
	item.stack_size_changed.connect(_on_item_stack_size_changed.bind())
	
func clear_item() -> void:
	# Set control visibility
	$Label.visible = false
	$MarginContainer/TextureRect.texture = _empty_texture

	_on_item_stack_size_changed(0)
	if _current_item != null:
		_current_item.stack_size_changed.disconnect(_on_item_stack_size_changed.bind())
	
	_current_item = null

func _on_item_stack_size_changed(new_size: int) -> void:
	$Label.text = "%s" % new_size
