extends Control

func update_room():
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'mother'      : ''
	}
	place.inter = 'Dial2'
