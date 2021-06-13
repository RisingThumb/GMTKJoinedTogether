extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func set_discord(newDiscord: int) -> void:
	$HBoxContainer2/HSlider.value = newDiscord

func set_money(newMoney: int) -> void:
	$HBoxContainer/MoneyAmount.text = str(newMoney)
	
