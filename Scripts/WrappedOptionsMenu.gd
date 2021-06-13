extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta) -> void:
	self.text = "* " + $TextureRect/TextChoice.text

func add_item(var textToAdd : String) -> void:
	$TextureRect/TextChoice.add_item(textToAdd)

func selected() -> int:
	return $TextureRect/TextChoice.selected

func clear():
	$TextureRect/TextChoice.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
