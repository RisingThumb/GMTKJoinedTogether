extends Control


var day = 1
var money = 30
onready var topicLabel = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Topic
onready var titleChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/ArticleTitle
onready var textChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/TextChoice
onready var imageChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Imagechoice
onready var captionChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/CaptionChoice
onready var studyChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/StudyChoice

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
	for a in [titleChoice, textChoice, imageChoice, captionChoice, studyChoice]:
		a.clear()
	# populate this guy
	var titles = ["Big chungus, has fungus"]
	var texts = ["Big chungus has escaped, be careful"]
	var images = ["res://icon.png"]
	var captions = ["Colorised: Chungal Fungi"]
	var studies = ["10% liklihood of making a chungus big"]
	
	for title in titles:
		titleChoice.add_item(title)
	for text in texts:
		textChoice.add_item(text)
	for image in images:
		imageChoice.add_icon_item(load(image), "")
	for caption in captions:
		captionChoice.add_item(caption)
	for study in studies:
		studyChoice.add_item(study)
	# Gets called when the agency is selected.


func _on_OptionButton_item_selected(index):
	print(index)
	$AgencyPanel/CenterContainer/OptionButton.disabled = true
	$Fader.play("AgencyPanelFadeOut")
