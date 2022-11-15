extends Button
class_name PlayButton

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "play")

func play():
# warning-ignore:return_value_discarded
	Fmod.play_one_shot("event:/UI/Validate", self)
	Fmod.play_one_shot("event:/Environment/Transition_Step", self)
	get_tree().change_scene('res://scenes/Main.tscn')
	Fmod.play_one_shot("event:/Environment/Ambiance", self)
