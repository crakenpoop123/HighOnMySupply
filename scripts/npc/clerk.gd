extends Node2D

# greeting / no meaning dialog
var clerk_greeting_responses = ["Can I help you?", "Hm?", "How can I help?", "???", "Hello?"]

# interested dialog
var clerk_interested = ["Could I have X amount of gummy worms please?", "I would like X gummy worms.", "Give me X amount of gummy worms, NOW", "I NEED X amount of gummy worms NOW", "GIVE ME X GUMMY WORMS OR I’M GOING TO DIE, I NEED IT PLEASE PLEASE PLEASE."]

# positive dialog
var clerk_positive = ["Thank you.", "Much appreciated", "Great.", "If you insist!", "Amazing stuff, thanks."]

# negative dialog
var clerk_negative = ["What do you want? Move.", "I have places to be.", "Get out of my face.", "I don’t want to hear it.", "Waste of my time"]

func player_interact():
	$"../../Player".talking(form_response())

func form_response():
	var response: String = ""
	var response_type: int = randi_range(1, 4)
	# var response_type: int = 2 # subject to be changed later for different scenarios
	
	print(response_type)
	
	if response_type == 1: # greeting
		response = clerk_greeting_responses[randi_range(1-1, 5-1)]
		
	elif response_type == 2: # positive
		response = clerk_positive[randi_range(1-1, 5-1)]
	
	elif response_type == 3: # negative
		response = clerk_negative[randi_range(1-1, 5-1)]
	
	elif response_type == 4: # interested
		response = clerk_interested[randi_range(1-1, 5-1)]
	return response
