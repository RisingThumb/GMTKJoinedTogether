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

func set_briefs(var briefs:Array) -> void:
	self.briefs = briefs

func _process(delta) -> void:
	var textToUse = briefs[$TextureRect/TextChoice.selected]
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
