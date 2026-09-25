extends Control

var curr_npc = null

var choice_chosen = 0

var all_choices = []

var choice_dict = {}

func display_text(text: String, npc = null):
	# Update text
	$TextBox.text = text
	
	# Set curr npc
	curr_npc = npc
	
	# Show the textbox
	globals.see_text = true
	
	# Fixes a crash
	if curr_npc:
		curr_npc.see_text = true
	

var test_choice_dict = { # Shopkeep test choices
	"1_text": "Sell Gummy Worms", 
	"2_text": "Leave", 
	"1": {
		"main_text": "Sure! I'll buy some gummy worms! I will buy them for $10 apiece", 
		"1_text": "Sell 1 Gummy Worm", 
		"2_text": "Sell 10 Gummy Worms", 
		"3_text": "Leave", 
		"1": {
			"func": "sell_gummy_worms", 
			"arg": 1
		}, 
		"2": {
			"func": "sell_gummy_worms", 
			"arg": 10
		}, 
		"3": {
			"func": "_on_exit_button_button_up"
		}
	}, 
	"2": {
		"func": "_on_exit_button_button_up"
	}
	
}

func _process(_delta: float) -> void:
	update_choices()

func display_choices(text_dict):
	choice_chosen = 0
	all_choices = []
	choice_dict = text_dict
	
	update_choices()


func update_choices():
	# Get the dict representing the current choices
	var curr_dict = get_curr_level_dict(choice_dict)
	
	# Check if there are any functions to call
	call_choice_funcs(curr_dict)
	
	# Update the visuals for the text choices
	update_choice_boxes(curr_dict)
	
	# Update the large text box at the bottom of the screen
	update_text_box(curr_dict)

# Call the function in the current dict, if there is one
func call_choice_funcs(curr_dict):
	if "func" in curr_dict:
		if "arg" in curr_dict:
			call_deferred(curr_dict["func"], curr_dict["arg"])
		else:
			call_deferred(curr_dict["func"])

# Go through the dict to find the current
func get_curr_level_dict(top_dict):
	# Check there is a non-zero num of choices
	if len(all_choices) == 0:
		return top_dict
	
	var curr_dict = top_dict
	
	# Iterate through all choices
	for choice in all_choices:
		
		# Check the choice is in the curr_dict
		if str(choice) in curr_dict:
			# Update curr_dict
			curr_dict = curr_dict[str(choice)]
	
	return curr_dict

# Update the text for each choice
func update_choice_boxes(dict):
	# Update Choice 1
	if "1_text" in dict:
		$ChoiceNodes/Choice1.text = dict["1_text"]
		$ChoiceNodes/Choice1.show()
	else:
		$ChoiceNodes/Choice1.hide()
	
	# Update Choice 2
	if "2_text" in dict:
		$ChoiceNodes/Choice2.text = dict["2_text"]
		$ChoiceNodes/Choice2.show()
	else:
		$ChoiceNodes/Choice2.hide()
	
	# Update Choice 3
	if "3_text" in dict:
		$ChoiceNodes/Choice3.text = dict["3_text"]
		$ChoiceNodes/Choice3.show()
	else:
		$ChoiceNodes/Choice3.hide()

# Update the main text box
func update_text_box(curr_dict):
	if "main_text" in curr_dict:
		$TextBox.text = curr_dict["main_text"]

# Buy amount gelatin
func buy_gelatin(amount):
	# Avoid debt
	if globals.money >= globals.gelatin_cost * amount:
		
		# Decrease money
		globals.money -= globals.gelatin_cost * amount 
		
		# Increase gelatin
		globals.inventory_ingredients["gelatin"]["stock"] += amount
		
		# Print thank you message
		globals.clerk_bought_from = true
		$"..".talking($"../../Clerk/StaticBody2D".form_response(), "clerk")
		globals.clerk_bought_from = false
		
	# If you do not have the money
	else:
		# Politely tell the user they are broke
		$"..".display_gui_error("Sorry, you do not have the funds for this!")
		# Exit the text 
		_on_exit_button_button_up()

# Sell amount gummy worms
func sell_gummy_worms(amount):
	if globals.inventory_ingredients["gummy_worm"]["stock"] >= amount:
		# Take gummy worms from the user
		globals.inventory_ingredients["gummy_worm"]["stock"] -= amount
		
		# Give the user money
		globals.money += amount * globals.gummy_worm_sell_price
		
		# Exit the text
		_on_exit_button_button_up()
	
	# If the player doesn't have enough gumm worms
	else:
		# Tell the user they don't have the stock for this
		$"..".display_gui_error("Sorry, you do not have enough gummy worms for this")
		# Exit the text 
		_on_exit_button_button_up()

func _on_exit_button_button_up() -> void:
	# Hide the textbox
	globals.see_text = false
	
	# Ensure curr_npc isn't null
	if curr_npc:
		curr_npc.see_text = false


# Update choice when choice 1 pressed
func _on_choice_1_pressed() -> void:
	choice_chosen = 1
	all_choices.append(choice_chosen)
	update_choices()


# Update choice when choice 1 pressed
func _on_choice_2_pressed() -> void:
	choice_chosen = 2
	all_choices.append(choice_chosen)
	update_choices()


# Update choice when choice 1 pressed
func _on_choice_3_pressed() -> void:
	choice_chosen = 3
	all_choices.append(choice_chosen)
	update_choices()
