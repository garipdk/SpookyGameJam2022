extends Button
class_name SoundButton

export(String) var sound : String

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "on_pressed")

func on_pressed():
	Fmod.play_one_shot(sound, Skipp_Fmod_Errors)

