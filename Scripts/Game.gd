extends Control


var day = 1
var money = 30

func _ready():
	$DayPanel.visible = true
	$AgencyPanel.visible = false
	$NewspaperCreationPanel.visible = false
	$BillPanel.visible = false
	
	$Fader.play("DayPanelFadeOut")

func dayForward():
	day+=1
	$DayPanel/CenterContainer/DayLabel.updateDayText(day)

func setupAgenciesAvailable():
	$AgencyPanel/CenterContainer/OptionButton.items.clear()
	$AgencyPanel/CenterContainer/OptionButton.add_item("Select an Agency to work for")
	$AgencyPanel/CenterContainer/OptionButton.selected = 0
	$AgencyPanel/CenterContainer/OptionButton.add_item("Agency day 1")

func setupTopicDropDowns():
	# Gets called when the agency is selected.
	pass


func _on_OptionButton_item_selected(index):
	print(index)
	$AgencyPanel/CenterContainer/OptionButton.disabled = true
	$Fader.play("AgencyPanelFadeOut")
