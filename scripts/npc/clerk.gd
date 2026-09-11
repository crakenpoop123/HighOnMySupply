extends Node2D

# greeting / no meaning dialog
var clerk_greeting_responses = ["Can I help you?", "Huh?", "What.", "Ah!", "*floorboards creak*"]

# positive dialog
var clerk_positive = ["Welcome in, have a look around.", "Feel free to browse.", "I hope you enjoy our product.", "Ah, my favourite customer!", "Ah, my only customer!"]

# negative dialog
var clerk_negative = ["If you’re not gonna buy anything then leave.", "Leave. Now.", "We don’t want you here, no one does.", "Exit the premises immediately.", "Leave or I'll call the very real cops."]

# bought dialog
var clerk_bought = ["Thank you for purchasing!", "Throw a gummy worm for a tip?", "Don’t mess around with that.", "Be careful.", "No refunds."]

func player_interact():
	$"../../Player".talking(form_response())

func form_response():
	var response: String = ""
	var response_type: int = randi_range(1, 4)
	if globals.money > 5:
		response_type = 3
	# var response_type: int = 2 # subject to be changed later for different scenarios
	
	print(response_type)
	
	if response_type == 1: # greeting
		response = clerk_greeting_responses[randi_range(1-1, 5-1)]
		
	elif response_type == 2: # positive
		response = clerk_positive[randi_range(1-1, 5-1)]
	
	elif response_type == 3: # negative
		response = clerk_negative[randi_range(1-1, 5-1)]
	
	elif response_type == 4: # interested
		response = clerk_bought[randi_range(1-1, 5-1)]
	return response
