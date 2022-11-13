extends Control
class_name Choices

onready var buttons : Array = [
	$VBox/HBox/HBox/Choice1,
	$VBox/HBox/HBox/Choice2,
	$VBox/HBox/HBox/Choice3,
]
onready var texts : Array = [
	$VBox/HBox/HBox/Choice1/VBox/Text,
	$VBox/HBox/HBox/Choice2/VBox/Text,
	$VBox/HBox/HBox/Choice3/VBox/Text,
]

onready var npr_gauge = $VBox/HBoxTop/VBoxContainer/NPRGauge
onready var npr_button = $VBox/HBoxTop/VBoxContainer/NPRButton

export(float) var answer_time = 7.0

onready var timer : Timer = $Timer

signal choice_made

var text_speed = 0.008
var is_question : bool = false
var nrep = 0
var cur_rep = 0

func _ready():
	GameState.choices = self
# warning-ignore:return_value_discarded
	timer.connect("timeout", npr_button, "emit_signal", ["pressed"])
	npr_button.connect("pressed", self, "_on_choice", [0])
	for i in range(buttons.size()):
		buttons[i].connect("pressed", self, "_on_choice", [i+1])

func _process(_delta):
	if $VBox/HBoxTop/Panel/Label.percent_visible < 1.0:
		$VBox/HBoxTop/Panel/Label.percent_visible += text_speed
	elif $VBox/HBox/Dialog/VBox/Text.percent_visible < 1.0:
		$VBox/HBox/Dialog/VBox/Text.percent_visible += text_speed
	elif is_question:
		if texts[cur_rep].percent_visible < 1.0:
			texts[cur_rep].percent_visible += text_speed
			if texts[cur_rep].percent_visible >= 1.0 and cur_rep <= nrep:
				cur_rep += 1
		elif timer.is_stopped():
			timer.start(answer_time)
		else:
			npr_gauge.value = timer.time_left / answer_time
			
func _on_choice(choice : int):
	timer.stop()
	npr_gauge.value = 1.0
	var d = GameState.le_dialogue
	if d != null :
		if d is Interactions.dialogue_type:
			GameState.trigger_action(d.possible_reponses[choice].next)

func _on_say_nothing():
	emit_signal("choice_made", 0)
	
func _on_choice1():
	emit_signal("choice_made", 1)
	
func _on_choice2():
	emit_signal("choice_made", 2)
	
func _on_choice3():
	emit_signal("choice_made", 3)
	
func set_description(id : String):
	timer.stop()
	npr_gauge.value = 1.0
	if id == "":
		GameState.le_dialogue = null
		self.set_visible(false)
		return
	self.set_visible(true)
	
	var d : description = Interactions.lines[id]
		
	if d.energie_add > 0:
		Fmod.play_one_shot("event:/UI/Energy_Fill", self)
	elif d.energie_add < 0:
		Fmod.play_one_shot("event:/UI/Energy_Use", self)
	GameState.energy += d.energie_add
	GameState.stress += d.stress_add
	
	GameState.le_dialogue = d
	$VBox/HBox/Dialog/VBox/Text.text = d.text
	$VBox/HBox/Dialog/VBox/Text.percent_visible = 0.0
	if d.personne_parlant != "":
		$VBox/HBoxTop/Panel/Label.text = d.personne_parlant
		$VBox/HBoxTop/Panel/Label.percent_visible = 0.0
	else:
		$VBox/HBoxTop/Panel/Label.set_visible(false)
	nrep = 0 if not d is Interactions.dialogue_type else \
			   d.possible_reponses.size() - 1
	is_question = nrep != 0
	print(str(nrep))
	for i in range(nrep):
		buttons[i].set_reponse(d.possible_reponses[i+1])
		buttons[i].set_visible(true)
		
	for i in range(nrep, 3):
		buttons[i].set_visible(false)
	
	if is_question:
		cur_rep = 0
	$VBox/HBoxTop/VBoxContainer.set_visible(is_question)
	$VBox/HBox/HBox.set_visible(is_question)
