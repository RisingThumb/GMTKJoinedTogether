extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_discord(newDiscord: int) -> void:
	$HSlider.value = newDiscord

func set_money(newMoney: int) -> void:
	$HBoxContainer/MoneyAmount.text = str(newMoney)
	
