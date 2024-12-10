extends Node

var currentEnvironment: GameEnvironment

func _ready() -> void:
	currentEnvironment = GameEnvironment.new()
	
func getEnvironment() -> GameEnvironment:
	var kidsNode = get_node("../Kids")
	var kids = kidsNode.kids
	currentEnvironment.setKids(kids)
	return currentEnvironment
