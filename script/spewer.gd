extends Node2D

#
#	Exports
#

# The inventory to draw from when spewing
@export var inventory: ItemInventory = null

#
#	Godot Functions
#

func _physics_process(_delta):
	look_at(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			spew()

#
#	Public Functions
#

func spew() -> void:
	# If there's nothing in our inventory, EXIT EARLY
	if inventory.total_used_slots() == 0:
		print("Nothing to spew!")
		return
	
	# Grab the first item we can spew, and try to split the stack. If we can't
	# split the stack, then just use the whole thing.
	var item_stack = inventory.peek_last_filled_slot()
	var item = item_stack.split_stack(1)
	if item == null: item = item_stack
	
	# Place the item in the world
	var error = item.put_in_world(get_window())
	if error != ItemInstance.InstanceError.OK:
		printerr("Failed to spew item: %s" % error)
		return
	
	var world_item: WorldItem2D = item.get_world_item()
	world_item.global_position = $ExitPoint.global_position
	if not world_item.lock_rotation:
		world_item.global_rotation = $ExitPoint.global_rotation
	world_item.apply_impulse(Vector2.RIGHT.rotated($ExitPoint.global_rotation) * 700)
