extends Control

var menu: int = 0
var text_array = ["Tutorial - Movement
Press w a s d to move or use arrow keys
Press tab to open the inventory
Here you can drag buildings and items into your hotbar
Press tab to close the inventory
If you wish to place a building then you can click your hotbar and move your mouse to where you want to place it and click
Once placed you can press E to interact
You can also interact with npcs with E
",

"Tutorial - Sugar
Go to the grass
Place a farm plot and water it to speed it up
Cut it down
put the sugarcane you just got into a shredder
Bring the shredded cane to the crusher
Bring the cane juice to the boiler
Wait for it to turn into wet sugar
Bring the wet sugar to the dryer
Congrats, you have sugar!
",

"Tutorial - Gummy worms
Once you have made sugar go to the store and buy some gelatin
The store is to the left of the basement
Put the sugar, gelatin, and water into a saucepan
Put it onto the stove
In the next minigame take it off of the stove and pour it into the mold
Congrats, you have gummy worms!
",

"Tutorial - Selling gummy worms
Once you have gummy worms you need to sell them
You can do that by walking up to any npc and interacting with them
Once you've interacted with them you'll have an option to sell them some gummy worms
The price changes every now and then so make sure to buy low and sell high!
", 
"Tutorial - Decay
Over time, your screen will start to get more and more corrupted
This is due to the decay and corruption of your eyes
Luckily, the gummy worms you have been making are some pretty strong stuff
Eating a gummy worm will lessen the decay by a bit"
]

func _process(delta: float) -> void:
	$RichTextLabel.text = text_array[menu] # set the text to the right page
	if menu != 3: # If you are on a page you can go forwards on
		$NextButton.visible = true # Show next button
	else: # If you are on a page you can't go forwards on
		$NextButton.visible = false # Hide next button
	if menu != 0: # If you are on a page you can go back on
		$BackButton.visible = true # Show back button
	else: # If you aren't on a page you can go back on
		$BackButton.visible = false #Hide back button
		
func _on_button_button_up() -> void: # Destroy self when closed
	self.queue_free()

func _on_button_2_button_up() -> void: #Increase menu by one
	menu += 1

func _on_button_3_button_up() -> void: # Decrease menu by one
	menu -= 1
