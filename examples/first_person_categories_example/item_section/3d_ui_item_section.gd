@tool
extends VBoxContainer
class_name UIItemSection3D

@export var section_name: String = "":
	set(value):
		section_name = value
		if get_node_or_null("HeaderPanel/Label"):
			$HeaderPanel/Label.text = value
@export var item_preview_scene: PackedScene = null
@export var filter: ItemFilter = null

@onready var _preview_parent = $VBoxContainer

var _spawned_previews: Array[UIItemPreview3D] = []

#
#	Public Functions
#

func add_item(item: ItemInstance) -> void:
	var new_preview = _spawn_item_preview(item)
	_spawned_previews.push_back(new_preview)
	
func remove_item(item: ItemInstance) -> void:
	var to_remove: Array[UIItemPreview3D] = []
	for preview in _spawned_previews:
		if preview.item == item: 
			to_remove.push_back(preview)
			preview.queue_free()
			
	for preview in to_remove:
		_spawned_previews.erase(preview)

#
#	Private Functions
#

func _spawn_item_preview(item: ItemInstance) -> UIItemPreview3D:
	var new_preview = item_preview_scene.instantiate()
	_preview_parent.add_child(new_preview)
	
	new_preview.display_item(item)
	return new_preview
