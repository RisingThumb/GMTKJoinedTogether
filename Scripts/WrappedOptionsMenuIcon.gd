extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var day = 0
var agency = ""
var briefs = [""]

func set_day(var day:int) -> void:
	self.day = day

func set_agency(var agency:String) -> void:
	self.agency = agency

func set_briefs(var briefs:Array) -> void:
	self.briefs = briefs

func _process(delta) -> void:
	var index = $Label/TextureRect/TextChoice.selected
	var textToUse
	if index == -1:
		textToUse = ""
	else:
		textToUse = briefs[index]
	$Label.text = "* " + textToUse

func add_item(var textToAdd : String) -> void:
	$Label/TextureRect/TextChoice.add_item(textToAdd)

func add_icon_item(var imagePath: String, textToAdd : String) -> void:
	var img = load(imagePath)
	$Label/TextureRect/TextChoice.add_icon_item(img, textToAdd)
	$TextureRect.texture = img
	

func selected() -> int:
	return $Label/TextureRect/TextChoice.selected

func clear():
	$Label/TextureRect/TextChoice.clear()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
