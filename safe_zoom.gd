extends StaticBody3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D



func _ready() -> void:
	var material = mesh_instance_3d.material_override
	if material == null:
		material = StandardMaterial3D.new()
		mesh_instance_3d.material_override = material
	material.albedo_color = Color(0,0.5,0)
	pass # Replace with function body.
