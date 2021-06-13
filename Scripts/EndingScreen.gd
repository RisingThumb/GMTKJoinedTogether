extends Node

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
	$CenterContainer/VBoxContainer/Label.text = ArticleContent.ending_label_message
	
	pass
