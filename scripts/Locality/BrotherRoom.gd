extends Control

func update_room():
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : { 'inter' : '',
						   'is_usable' : false,
						   'limited_try' : true,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : false, },
		'magazine'     : { 'inter' : 'Dial14',
						   'is_usable' : true,
						   'limited_try' : true,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'trash_can'    : { 'inter' : 'Des8',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'football'     : { 'inter' : '',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'brother_door_go_out' : { 'inter' : 'goto:Hall2',
								  'is_usable' : true,
								  'limited_try' : false,
								  'num_try' : 1,
								  'set_num_try' : false,
								  'disapear' : false,
								  'visible' : true, },
	}
	place.inter = ''

func _process(_delta):
	if GameState.place_manager.places[name].elements['brother']['visible'] and\
	   GameState.place_manager.places['Hall2'].elements['brother_door_enter']['is_usable']:
		GameState.place_manager.places['Hall2'].elements['brother_door_enter']['is_usable'] = false
	
	if GameState.stress >= 40.00 and not GameState.stress_on:
		GameState.stress_period_des = 'Des10'
		GameState.stress_on = true
	GameState.place_manager.set_all_object_parameters_on_scene(self)
