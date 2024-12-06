extends Node

var currentEnvironment: GameEnvironment

func _ready() -> void:
	GameEnvironment.new()
	
func getEnvironment() -> GameEnvironment:
	return currentEnvironment
