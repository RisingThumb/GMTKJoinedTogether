extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta) -> void:
	$Label.text = "* " + $Label/TextureRect/TextChoice.text

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
