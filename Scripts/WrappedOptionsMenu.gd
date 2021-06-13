extends Label


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
	self.briefs = [""]

func set_briefs(var briefs:Array) -> void:
	self.briefs = briefs

func _process(delta) -> void:
	var index = $TextureRect/TextChoice.selected
	var textToUse
	if index == -1:
		textToUse = ""
	else:
		textToUse = briefs[index]
	self.text = "* " + textToUse

func add_item(var textToAdd : String) -> void:
	$TextureRect/TextChoice.add_item(textToAdd)

func selected() -> int:
	return $TextureRect/TextChoice.selected

func clear():
	$TextureRect/TextChoice.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextChoice_item_selected(index):
	$AudioStreamPlayer.play()
	pass # Replace with function body.
