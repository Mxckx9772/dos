extends Node3D

@export var visionRadius: int = 5
@export var speed: int = 5
@export var runSpeed: int = 5

var environment: Node

func _ready() -> void:
	environment = get_node("../Environment")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var currentEnvironment = environment.getEnvironment()

	var kid = findKids(currentEnvironment.kids)
	translate(Vector3(0.1, 0, 0.1))
	if kid != null:
		catchKid(kid)
	else:
		followPath()
	
func findKids(kids: Array[Vector2]):
	var position2D = Vector2(position.x, position.z)
	for kid in kids:
		var distance = position2D.distance_to(kid)
		if distance < visionRadius: 
			return kid
	return null

func catchKid(kid: Vector2) -> void:
	var position2D = Vector2(position.x, position.z)
	
func followPath() -> void:
	print("HMMMM")
