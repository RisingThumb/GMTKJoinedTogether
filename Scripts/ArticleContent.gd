extends Node

export(String) var article_content_file

func _ready():
	var document = load_file(article_content_file)
	var parsed = JSON.parse(document)
	
	if parsed.error != OK:
		get_tree().quit()
		
	
	
	pass

func load_file(name):
	var file = File.new()
	
	file.open(name, File.READ)
	var content = file.get_as_text()
	
	file.close()
	return content
