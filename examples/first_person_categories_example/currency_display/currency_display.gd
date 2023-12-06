extends HBoxContainer
class_name FPCE_CurrencyDisplay

var item: ItemInstance = null

@onready var _preview_sprite: TextureRect = $CurrencyIcon
@onready var _count_label: Label = $CountLabel

func display_item(item_to_display: ItemInstance):
	item = item_to_display
	
	if item == null:
		_preview_sprite.texture = null
		_count_label.text = ""
		return
		
	_preview_sprite.texture = item.get_descriptor().preview_icon
	_update_count(item.get_stack_size())
	
	item_to_display.stack_size_changed.connect(_update_count.bind())

func _update_count(count: int) -> void:
	_count_label.text = str(count)
