extends Node

func _process(delta):
	$Panel/CenterContainer/VBoxContainer/Label.text = ArticleContent.ending_label_message
	$TextureRect.texture = ArticleContent.ending_image

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
