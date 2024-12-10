extends Node3D
@onready var mesh_instance_3d: MeshInstance3D = $Candy/MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var material = mesh_instance_3d.material_override
	if material == null:
		material = StandardMaterial3D.new()
		mesh_instance_3d.material_override = material
	material.albedo_color = Color(1,0,1)
	pass # Replace with function body.
