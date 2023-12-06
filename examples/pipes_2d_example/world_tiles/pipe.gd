extends Node2D
class_name Pipe

#
#	Exports
#

## The inventory to push_items_into
@export var to_push_to: ItemInventory = null
@export var pipe_to_push_to: Pipe = null

#
#	Private Variables
#

## Our internal inventory
@onready var _inventory: ItemInventory = $ItemInventory as ItemInventory

#
#	Godot Functions
#

func _ready():
	_inventory.slot_updated.connect(_on_slot_updated.bind())

#
#	Signals
#

func _on_slot_updated(_slot: int, item: ItemInstance):
	if item == null: return
	
	# Start a timer to try and push this in half a sec
	await get_tree().create_timer(0.5).timeout
	_try_push()


#
#	Private Functions
#

func _try_push():
	if _get_push_to() == null:
		return
	if _inventory.total_used_slots() == 0:
		return
		
	# Try to pump the item
	_inventory.peek_last_filled_slot().put_in_inventory(_get_push_to())


func _get_push_to() -> ItemInventory:
	if pipe_to_push_to != null: return pipe_to_push_to._inventory
	return to_push_to
