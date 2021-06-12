extends Node

export(String) var article_content_file
var article_content

func get_event(day: int) -> String:
	return article_content[day]["event"]

func get_agencies(day: int) -> String:
	var agencies = article_content[day]["agencies"]
	return agencies.keys()

func get_title_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "titles")
	
func get_content_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "content")
	
func get_image_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "images")

func get_interview_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "interviews")
	
func get_study_strings(day: int, agency: String) -> Array:
	return _get_element_strings(day, agency, "studies")

func _get_element_strings(day, agency, attribute) -> Array: 
	var agencies = article_content[day]["agencies"]
	var elements = agencies[agency][attribute]
	
	var element_strings = []
	
	for element in elements:
		element_strings.push_back(element["text"])
		
	return element_strings

func _ready():
	var document = _load_file(article_content_file)
	var parsed = JSON.parse(document)
	
	if parsed.error != OK:
		_panic()
	
	article_content = parsed.result
	
	var result = get_title_strings(0, "name of the agency")
	print(result)

func _load_file(name):
	var file = File.new()
	file.open(name, File.READ)
	
	var content = file.get_as_text()
	file.close()
	
	return content

func _panic():
	get_tree().quit()
