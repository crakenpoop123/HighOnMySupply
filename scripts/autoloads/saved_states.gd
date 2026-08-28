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
