extends AudioStreamPlayer

var songs = ["res://Audio/Music.mp3", "res://Audio/Music2.mp3", "res://Audio/Music3.mp3"]

func _ready():
	songs.shuffle()
	doNextMusic()

func doNextMusic():
	var thisSong = songs.pop_front()
	songs.push_back(thisSong)
	self.stream = load(thisSong)
	self.play(0)

func _on_Music_finished():
	doNextMusic()
