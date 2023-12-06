extends Node2D
class_name Pumper

#
#	Exports
#

## The inventory to push items into
@export var to_push_to: ItemInventory = null
@export var pipe_to_push_to: Pipe = null
## The inventory to pull items from
@export var to_pull_from: ItemInventory = null

#
#	Private Variables
#

## Our internal inventory
@onready var _inventory: ItemInventory = $ItemInventory as ItemInventory

#
#	Signals
#

func _on_tick_timer_timeout():
	# If we have items and a place to push em, PUSH EM
	if _inventory.total_used_slots() > 0 and _get_push_to() != null:
		var item = _inventory.peek_last_filled_slot()
		item.put_in_inventory(_get_push_to())
	
	# If we have slots and a place to pull from, PULL!
	if _inventory.total_unused_slots() > 0 and to_pull_from != null:
		var found_item = to_pull_from.peek_last_filled_slot()
		if found_item != null:
			found_item.put_in_inventory(_inventory)

#
#	Private Functions
#

func _get_push_to() -> ItemInventory:
	if pipe_to_push_to != null: return pipe_to_push_to._inventory
	return to_push_to
