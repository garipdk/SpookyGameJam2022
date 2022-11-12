extends Node2D
class_name PlaceManager

var scenes : Dictionary = {
	'Room' : preload("res://scenes/Chambre.tscn")
}

var places : Dictionary = {
	'Room' : place.new()
}

func interact(name : String):
	# Démarrer interaction avec l'objet 'name'
	print('Interact with ', name)
	# Le nom de l'action à déclencher
	#var action = places[GameState.location].elements[name]
	#get_parent().get_child(0).set_description(action)

func _ready():
	GameState.place_manager = self
	go_to(GameState.location)

func go_to(place : String):
	GameState.location = place
	for c in get_children():
		remove_child(c)
		c.queue_free()
	add_child(scenes[place].instance())
	