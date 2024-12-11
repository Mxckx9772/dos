extends Node

var kids = []
var walk_methods = ["walk_direct","walk_random","walk_around"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for kid in get_children():
		kids.append(kid)
		_assign_walk_method(kid)


func _assign_walk_method(kid):
	var index_method = randi()% walk_methods.size()
	var method = walk_methods[index_method]
	kid._set_walk_method(method)
