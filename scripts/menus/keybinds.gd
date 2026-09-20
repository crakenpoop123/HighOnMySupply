extends Control

# Preload the keybinding
var keySetup = preload("res://scenes/gui/menus/menu_dependencies/keybinding.tscn")

# Setup some variables

var keybind_changing
var keybind_resetting
var keybind_listing

var curr_keybind
var curr_key
var curr_keycode

var locked_keys: Array[String] = ["QUIT"]
var locked_keys_key: Array[int] = [4194305]
var bound_keys = []

# Iterate through all the custom keybinds and add them
func _ready() -> void:
	for event in InputMap.get_actions():
		if not event.begins_with("ui_"):
			var curr_instance = keySetup.instantiate()
			
			curr_instance.connect("pressed", on_keybind_changed)
			
			#print("inputMap Event: " + str(event))
			
			curr_instance.Code = event
			
			get_node("KeybindScroll/KeybindVBox").add_child(curr_instance)


#Determine what to do when the keybinding buttons are pressed
func on_keybind_changed(type: String, key: String):
	#print("_on_keybind_changed: " + type + " - " + str(key))
	
	curr_keybind = key
	
	if type == "add":
		keybind_changing = true
	elif type == "reset":
		keybind_resetting = true
	else:
		keybind_listing = true
		get_keys(curr_keybind)
	
	
	curr_key = null
	
	%"Popup".show()


func _process(_delta: float) -> void:
	# Show text for if the user is changing a keybind
	if keybind_changing:
		if curr_key == null:
			%"Popup/MainText".text = "You are currently adding a key to keybind " + curr_keybind + ". The key being added is not yet pressed"
		else:
			%"Popup/MainText".text = "You are currently adding a key to keybind " + curr_keybind + ". The key being added is " + str(curr_key)
	# Show text for if the user is resetting a keybind
	elif keybind_resetting:
		if curr_keybind in locked_keys:
			%"Popup/MainText".text = "You are currently resetting the keybind " + curr_keybind + ". This keybind is locked and as such will keep the key " + OS.get_keycode_string(locked_keys_key[locked_keys.find(curr_keybind)]) + " after resetting"
		else:
			%"Popup/MainText".text = "You are currently resetting the keybind " + curr_keybind + ". This action cannot be undone"
	# Show text for if the user is listing the keys in a keybind
	elif keybind_listing:
		%"Popup/MainText".text = "The keys applied to this keybind are: " + str(bound_keys).substr(1, len(str(bound_keys)) - 2)


# Get a constantly changing stream of the recently pressed keys
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.is_echo():
		curr_key = OS.get_keycode_string(event.key_label)
		curr_keycode = event.keycode
		#print(curr_key + str(curr_keycode))


# Get the keys bound to a keybind
func get_keys(key: String):
	bound_keys.clear()
	if InputMap.has_action(key):
		for event in InputMap.action_get_events(key):
			if event is InputEventKey:
				# Get the user-friendly text of the physical key
				var key_name = OS.get_keycode_string(event.physical_keycode)
				bound_keys.append(key_name)
				print(key_name)
				print(event)
	return bound_keys


# Proceed with the keybind action
func _on_yes_button_up() -> void:
	# Proceed with changing the keybind
	if keybind_changing:
		var alreadyAdded = false
		for event in InputMap.action_get_events(curr_keybind):
			if event is InputEventKey and event.keycode == curr_keycode:
				alreadyAdded = true
				break
		
		if not alreadyAdded:
			var inputMappedKey := InputEventKey.new()
			inputMappedKey.physical_keycode = curr_keycode
			InputMap.action_add_event(curr_keybind, inputMappedKey)
	# Proceed with resetting the keybind
	if keybind_resetting:
		InputMap.action_erase_events(curr_keybind)
		if curr_keybind in locked_keys:
			var inputMappedKey := InputEventKey.new()
			inputMappedKey.keycode = locked_keys_key[locked_keys.find(curr_keybind)]
			InputMap.action_add_event(curr_keybind, inputMappedKey)
	
	keybind_changing = false
	keybind_resetting = false
	%"Popup".hide()

# Close the popup
func _on_no_button_up() -> void:
	keybind_changing = false
	keybind_resetting = false
	%"Popup".hide()
