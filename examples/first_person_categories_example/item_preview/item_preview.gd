extends PanelContainer
class_name FPCE_ItemPreview

var item: ItemInstance = null

@onready var _preview_sprite: TextureRect = $VBoxContainer/SpriteMargin/PreviewSprite
@onready var _name_label: Label = $VBoxContainer/DisplayNameLabel
@onready var _count_label: Label = $VBoxContainer/CountLabel

func display_item(item_to_display: ItemInstance):
	item = item_to_display
	
	if item == null:
		_name_label.text = ""
		_preview_sprite.texture = null
		_count_label.text = ""
		return
		
	_name_label.text = item.get_descriptor().get_display_name()
	_preview_sprite.texture = item.get_descriptor().preview_icon
	_count_label.text = str(item.get_stack_size())
	
	var on_stack_change_func = func(_size):
		display_item(item_to_display)
	
	item_to_display.stack_size_changed.connect(on_stack_change_func.bind())
