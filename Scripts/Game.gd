extends Control


var day = 1
var money = 0
var discord = 0

onready var topicLabel = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Topic
onready var titleChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/ArticleTitle
onready var textChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/TextChoice
onready var imageChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Imagechoice
onready var captionChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/CaptionChoice
onready var studyChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/StudyChoice
var selectedAgency = ""

func _ready() -> void:
	$DayPanel.visible = true
	$AgencyPanel.visible = false
	$EventPanel.visible = true
	$NewspaperCreationPanel.visible = false
	$BillPanel.visible = false
	
	$Fader.play("DayPanelFadeOut")

func dayForward() -> void:
	day += 1
	$DayPanel/CenterContainer/DayLabel.updateDayText(day)

func setupAgenciesAvailable() -> void:
	$AgencyPanel/CenterContainer/OptionButton.items.clear()
	$AgencyPanel/CenterContainer/OptionButton.add_item("Select an Agency to work for")
	$AgencyPanel/CenterContainer/OptionButton.selected = 0
	var agencies = ArticleContent.get_agencies(day - 1)
	for agency in agencies:
		$AgencyPanel/CenterContainer/OptionButton.add_item(agency)

func setupTopicDropDowns() -> void:
	for a in [titleChoice, textChoice, imageChoice, captionChoice, studyChoice]:
		a.clear()

	var titles = ArticleContent.get_title_strings(day - 1, selectedAgency)
	var texts = ArticleContent.get_content_strings(day - 1, selectedAgency)
	var images = ArticleContent.get_image_strings(day - 1, selectedAgency)
	var captions = ArticleContent.get_caption_strings(day - 1, selectedAgency)
	var studies = ArticleContent.get_study_strings(day - 1, selectedAgency)
	
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


func _on_OptionButton_item_selected(index: int) -> void:
	$AgencyPanel/CenterContainer/OptionButton.disabled = true
	$NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Publish.disabled = false
	selectedAgency = $AgencyPanel/CenterContainer/OptionButton.get_item_text(index)
	$Fader.play("AgencyPanelFadeOut")


func _on_EventButton_pressed() -> void:
	$NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Publish.disabled = true
	$Fader.play("EventPanelFadeOut")


func _on_Publish_pressed() -> void:
	$Fader.play("NewspaperCreationPanelFadeOut")


func _on_FinishFinanceButton_pressed() -> void:
	discord = 0
	$Fader.play("BillFadeout")
	dayForward()
