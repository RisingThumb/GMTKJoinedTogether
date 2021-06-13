extends Control


var day = 1
var money = 0
var discord = 0
var connections = 1
var moneyCost = 0
var interviews = false

export(int) var billsCost = 100
export(int) var connectionCost = 20
export(int) var interviewCost = 30

onready var topicLabel = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Topic
onready var titleChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/ArticleTitle
onready var textChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/TextChoice
onready var imageChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/ImageChoice
onready var captionChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/CaptionChoice
onready var studyChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/StudyChoice
onready var interviewChoice = $NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/InterviewChoice

var state
var event_index

var selectedAgency = ""
var calc

func _ready() -> void:
	$DayPanel.visible = true
	$AgencyPanel.visible = false
	$EventPanel.visible = true
	$NewspaperCreationPanel.visible = false
	$BillPanel.visible = false
	
	$Fader.play("DayPanelFadeOut")
	
	state = PathTree.get_next_state(null, discord)
	event_index = state.get_event_index()

func dayForward() -> void:
	day += 1
	
	state = PathTree.get_next_state(state, discord)
	event_index = state.get_event_index()
	
	$DayPanel/CenterContainer/DayLabel.updateDayText(day)

func setupAgenciesAvailable() -> void:
	$AgencyPanel/CenterContainer/OptionButton.clear()
	$AgencyPanel/CenterContainer/OptionButton.add_item("Select an Agency to work for")
	$AgencyPanel/CenterContainer/OptionButton.selected = 0
	var agencies = ArticleContent.get_agencies(event_index)
	for agency in agencies:
		$AgencyPanel/CenterContainer/OptionButton.add_item(agency)
	$EventPanel/CenterContainer/VBoxContainer/EventLabel.text = ArticleContent.get_event(day - 1)

func setupTopicDropDowns() -> void:
	for a in [titleChoice, textChoice, imageChoice, captionChoice, studyChoice, interviewChoice]:
		a.clear()
		a.set_agency(selectedAgency)
		a.set_day(event_index)
	$NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Topic.text = ArticleContent.get_event(day - 1)

	var titles = ArticleContent.get_title_strings(event_index, selectedAgency)
	titleChoice.set_briefs(titles)
	var texts = ArticleContent.get_content_strings_brief(event_index, selectedAgency)
	var textsFull = ArticleContent.get_content_strings(event_index, selectedAgency)
	textChoice.set_briefs(textsFull)
	var images = ArticleContent.get_image_strings(event_index, selectedAgency)
	var captions = ArticleContent.get_caption_strings(event_index, selectedAgency)
	captionChoice.set_briefs(captions)
	var studies = ArticleContent.get_study_strings(event_index, selectedAgency)
	studyChoice.set_briefs(studies)
	
	calc = ArticleContent.Calculator.new(event_index, selectedAgency, discord, money)
	
	for title in titles:
		titleChoice.add_item(title)
	for text in texts:
		print(text)
		textChoice.add_item(text)
	for image in images:
		imageChoice.add_icon_item(image, "")
	for caption in captions:
		captionChoice.add_item(caption)
	for study in studies:
		studyChoice.add_item(study)
	interviewChoice.visible = interviews
	if interviews:
		var interviewItems = ArticleContent.get_interview_strings(event_index, selectedAgency)
		#var interviewItemsLong = ArticleContent.get_interview_strings(event_index, selectedAgency)
		interviewChoice.set_briefs(interviewItems)
		for interview in interviewItems:
			interviewChoice.add_item(interview)


func _on_OptionButton_item_selected(index: int) -> void:
	$AgencyPanel/CenterContainer/OptionButton.disabled = true
	$NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Publish.disabled = false
	selectedAgency = $AgencyPanel/CenterContainer/OptionButton.get_item_text(index)
	$Fader.play("AgencyPanelFadeOut")


func _on_EventButton_pressed() -> void:
	$NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Publish.disabled = true
	$Fader.play("EventPanelFadeOut")
	$NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Publish.disabled = false


func _on_Publish_pressed() -> void:
	$Fader.play("NewspaperCreationPanelFadeOut")
	print(titleChoice.selected())
	
	calc.add_title(titleChoice.selected())
	calc.add_content(textChoice.selected())
	calc.add_image(imageChoice.selected())
	calc.add_caption(captionChoice.selected())
	calc.add_study(studyChoice.selected())
	if interviews:
		calc.add_interview(interviewChoice.selected())
	money = calc.get_money()
	discord = calc.get_discord()
	discord = clamp(discord,-500, 500)
	$BillPanel2/Stats.set_discord(discord)
	$BillPanel2/Stats.set_money(money)
	recalculateBills()
	
	$NewspaperCreationPanel/CenterContainer/ScrollContainer/Paper/Publish.disabled = true

func bankruptEnding():
	print("You went bankrupt")

func _on_FinishFinanceButton_pressed() -> void:
	money -= moneyCost
	if moneyCost < 0 :
		bankruptEnding()
	if !$BillPanel/CenterContainer/VBoxContainer/CheckBill.pressed:
		bankruptEnding()
	interviews = $BillPanel/CenterContainer/VBoxContainer/CheckInterview.pressed
	$BillPanel2/Stats.set_money(money)
	$Fader.play("BillFadeout")
	dayForward()

func recalculateBills():
	moneyCost = 0
	if $BillPanel/CenterContainer/VBoxContainer/CheckBill.pressed:
		moneyCost+=billsCost
	if $BillPanel/CenterContainer/VBoxContainer/CheckConnection.pressed:
		moneyCost+=connectionCost
	if $BillPanel/CenterContainer/VBoxContainer/CheckInterview.pressed:
		moneyCost+=interviewCost
	$BillPanel/CenterContainer/VBoxContainer/HBoxContainer/CurrentMoney.text = str(money)
	$BillPanel/CenterContainer/VBoxContainer/HBoxContainer2/CurrentExpenses.text = str(moneyCost)
	$BillPanel/CenterContainer/VBoxContainer/HBoxContainer3/NewMoneyAmount.text = str(money-moneyCost)

func _on_CheckBill_pressed():
	recalculateBills()


func _on_CheckConnection_pressed():
	recalculateBills()


func _on_CheckInterview_pressed():
	recalculateBills()
