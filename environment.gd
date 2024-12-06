extends Node

var currentEnvironment: GameEnvironment

func _ready() -> void:
	currentEnvironment = GameEnvironment.new()
	
func getEnvironment() -> GameEnvironment:
	return currentEnvironment
