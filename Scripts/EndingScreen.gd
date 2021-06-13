extends Node

func _process(delta):
	$CenterContainer/VBoxContainer/Label.text = ArticleContent.ending_label_message

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
	
	pass
