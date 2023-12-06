extends Control

@export var inventory: ItemInventory = null
@export var sections: Array[UIItemSection3D] = []


#
#	Private Functions
#

func _find_supported_section(item: ItemInstance) -> UIItemSection3D:
	for section in sections:
		if section.filter == null: 
			return section
		if section.filter.evaluate(item, null) == ItemFilter.FilterResult.PASS:
			return section
	return null

#
#	Signals
#

func _on_player_inventory_slot_updated(_index, item):
	# If an item is being added
	if item != null:
		# Get the first section that we can fit this in
		var section = _find_supported_section(item)
		if section:
			section.add_item(item)
	# If an item is being removed
	else:
		# Remove from all sections
		for section in sections:
			section.remove_item(item)
