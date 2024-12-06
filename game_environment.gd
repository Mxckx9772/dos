extends Object

class_name GameEnvironment

var kids: Array[Vector2]
var teacher: Vector2
var candy: Array[Vector2]

func _init():
	kids = [Vector2(0, 0)]
	candy = [Vector2(0, 0)]
	teacher = Vector2(0, 0)
