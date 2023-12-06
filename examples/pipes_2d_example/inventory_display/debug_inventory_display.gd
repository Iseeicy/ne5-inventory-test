extends PanelContainer

#
#	Exports
#

## How many visual columns this UI should have
@export var columns: int

## The inventory to visually represent
@export var inventory: ItemInventory = null

## The scene that extends DebugItemUIDisplay to spawn for each slot
@export var item_slot_scene: PackedScene = preload("res://examples/pipes_2d_example/inventory_display/debug_inventory_display.tscn")

#
#	Private Variables
#

var _slots: Array[DebugItemUIDisplay] = []

#
#	Godot Functions
#

func _ready():
	$GridContainer.columns = columns
	_slots.clear()
	for slot in inventory.get_all_slots():
		var item_ui: DebugItemUIDisplay = item_slot_scene.instantiate()
		$GridContainer.add_child(item_ui)
		item_ui.show_item(slot)
		_slots.append(item_ui)
	inventory.slot_updated.connect(_on_slot_changed.bind())

#
#	Signals
#

func _on_slot_changed(index: int, item: ItemInstance) -> void:
	_slots[index].show_item(item)
