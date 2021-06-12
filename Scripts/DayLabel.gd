extends Label



func _ready():
	updateDayText(1)

func updateDayText(day : int) -> void:
	self.text = "Day %d" % day
