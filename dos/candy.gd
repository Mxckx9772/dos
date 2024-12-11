extends Node3D
@onready var mesh_instance_3d: MeshInstance3D = $Candy/MeshInstance3D


@export var nbCandy = 200
var environment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	environment = get_node("../Environment")
	var material = mesh_instance_3d.material_override
	if material == null:
		material = StandardMaterial3D.new()
		mesh_instance_3d.material_override = material
	material.albedo_color = Color(1,0,1)
	print("Il y a "+str(nbCandy)+" bonbons dans le bol au départ")


func _process(delta: float) -> void:
	var currentEnvironment = environment.getEnvironment()
	var kids = currentEnvironment.kids
	for kid in kids:
		var kid2DPosition = Vector2(kid.position.x, kid.position.z)
		if isTouch(kid2DPosition) && nbCandy > 0:
			nbCandy -= 1
			print("Il reste "+str(nbCandy)+" bonbons dans le bol")
		elif nbCandy == 0:
			print("C'est fini, il n'y a plus de bonbon")
	

func isTouch(kid: Vector2) -> bool:
	var position2D = Vector2(position.x, position.z)
	var distance = position2D.distance_to(kid)
	return distance < 1
