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

# Recursively search all nodes and load the states for certain nodes 
#func load_states(node):
	#print("Loading states for node: ", node)
	#
	## Iterate over the children of current nodes
	#for child in node.get_children():
		## This is true when the child has code for loading a previous state 
		#if child.has_method("load_prev_state"):
			#child.load_prev_state()
		#
		## Recursively call the function
		#load_states(child)
