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

"Tutorial - should probably do one for selling them too maybe"
]

func _process(delta: float) -> void:
	$RichTextLabel.text = text_array[menu]
	if menu != 3:
		$Button2.visible = true
	else:
		$Button2.visible = false
	if menu != 0:
		$Button3.visible = true
	else:
		$Button3.visible = false
func _on_button_button_up() -> void:
	self.queue_free()

func _on_button_2_button_up() -> void:
	menu += 1

func _on_button_3_button_up() -> void:
	menu -= 1
