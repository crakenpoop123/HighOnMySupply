extends Node2D
var readable_name = "???"
# greeting / no meaning dialog
var homeless_greeting_responses = ["*Grunts*", "what.", "move.", "...", "*Cough cough*"]

# positive dialog
var homeless_positive = ["I remember when this place had real sugar...", "Nowadays everything is so expensive…", "At least Larribros would provide shelter…"]

# negative dialog
var homeless_negative = ["Scram, kid.", "Leave. Now.", "I’m trying to relax here.", "I have better things to do than talk to you", "Get a move on", "Get out of my house"]

# bought dialog
var homeless_misc = ["Give give give give give give give give.", "“I haven’t tasted one in 43 years, please.", "Don’t mess around with that.", "Just 1, please.", "Could I have a gummy worm for free? Please?"]

func player_interact():
	$"../../Player".talking(form_response(), "homeless guy")

func form_response():
	var response: String = ""
	var response_type: int = randi_range(1, 4)
	
	if response_type == 1: # greeting
		response = homeless_greeting_responses[randi_range(1-1, 5-1)]
		
	elif response_type == 2: # positive
		response = homeless_positive[randi_range(1-1, 3-1)]
	
	elif response_type == 3: # negative
		response = homeless_negative[randi_range(1-1, 6-1)]
	
	elif response_type == 4: # interested
		response = homeless_misc[randi_range(1-1, 5-1)]
	return response
