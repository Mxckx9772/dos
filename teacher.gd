extends Node3D

@export var visionRadius: int = 5
@export var speed: int = 5
@export var runSpeed: int = 10

var environment: Node
var currentDestination: Vector2

var destinations = [
	Vector2(0, -5),
	Vector2(0, -10),
	Vector2(-10, -5),
	Vector2(-2, 5),
	Vector2(-12, 8),
	Vector2(-2, -8),
	Vector2(-8, 12),
	Vector2(-10, -10),
]

func _ready() -> void:
	environment = get_node("../Environment")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var currentEnvironment = environment.getEnvironment()

	var kid = findKids(currentEnvironment.kids)
	if kid != null:
		catchKid(kid, delta)
	else:
		followPath(delta)
	
func findKids(kids: Array):
	var position2D = Vector2(position.x, position.z)
	for kid in kids:
		var distance = position2D.distance_to(Vector2(kid.position.x, kid.position.z))
		if distance < visionRadius and not kid.isCaught(): 
			return kid
	return null

func catchKid(kid, delta: float) -> void:
	var kidPosition = Vector2(kid.position.x, kid.position.z)
	var position2D = Vector2(position.x, position.z)
	if position2D.distance_to(kidPosition) < 1:
		kid.catch(delta)

	var direction = (kidPosition - position2D).normalized()
	var movement = direction * runSpeed * delta
	translate(Vector3(movement.x, 0, movement.y))
	
	
func followPath(delta: float) -> void:
	if currentDestination == Vector2.ZERO:
		currentDestination = destinations[ randi_range(0, 7)]
		
	var position2D = Vector2(position.x, position.z)
	if position2D.distance_to(currentDestination) < 1:
		currentDestination = destinations[ randi_range(0, 7)]
		
	var direction = (currentDestination - position2D).normalized()
	var movement = direction * speed * delta
	translate(Vector3(movement.x, 0, movement.y))
