extends Control

func update_room():
	$toilet.is_usable = GameState.toilet_whas_not_used

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : '',
		'staircase'    : 'goto:Room',
		'toilet'       : 'Des5',
		'plant'        : 'Des4',
		'door_kitchen' : 'goto:Kitchen1'
	}
	place.inter = 'Dial1'


func _process(_delta):
	if GameState.energy == 3:
		$toilet.is_usable = false
	else:
		$toilet.is_usable = GameState.toilet_whas_not_used
