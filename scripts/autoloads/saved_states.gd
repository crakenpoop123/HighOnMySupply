extends Node

var inv_arrays

var building_data: Dictionary

# Setup the building_data
# This is used over _ready because globals neds to fully load first
# This is called at the bottom of globals._ready()
func setup():
	inv_arrays = [globals.inventory_buildings, globals.inventory_ingredients]
	
	# Iterate over the inventory arrays
	for arr in inv_arrays:
		# Iterate through all keys in the array
		for key in arr.keys():
			# Add it to the building_data
			building_data[key] = {}
	#print("building data: ", building_data)

# Recursively search all nodes and save the states for certain nodes 
func save_states(node):
	print("Iterating children for node: ", node)
	
	# Iterate over the children of current nodes
	for child in node.get_children():
		# This is true when the child has code for saving the current state 
		if child.has_method("save_curr_state"):
			if child.build_type in building_data:
				if child.name in building_data[child.build_type]:
					print("Saving states for node: ", node)
					child.save_curr_state()
				else:
					create_save_data(child)
			else:
				create_save_data(child)
		
		# Recursively call the function
		await save_states(child)
		
	return true


func create_save_data(node):
	building_data[node.build_type][node.name] = {}
