extends Object

class_name GameEnvironment

var kids: Array
var teacher: Vector2
var candy: Array[Vector2]

func _init():
	kids = []
	candy = [Vector2(0, 0)]
	teacher = Vector2(0, 0)

func setKids(newKids): 
	kids = newKids
