extends Node3D
@onready var candy: Node3D = $"../../Candy"
@onready var teacher: Node3D = $Teacher
@onready var mesh_instance_3d: MeshInstance3D = $RigidBody3D/MeshInstance3D

#@onready var classroom: Node3D = $"../Classroom"

# state machine
enum State{
	WALK_TO_TARGET,
	RETURN_TO_SAFETY,
	CHILLING,
	IS_CAUGHT
}
var current_state: State = State.WALK_TO_TARGET

# distribuer le walk method / color
var walk_method = ""
var color_map = {
	"walk_direct" : Color(1.,0.,0.),
	"walk_random" : Color(0.,1.,0.),
	"walk_around" : Color(0.,0.,1.),
	"sad" : Color(0.5,0.5,0.5),
}

# for the base
var edge_left_back : float = -14.
var edge_right_front : float = 14.
var start_position :Vector2
var end_position:Vector2
var speed:float = 5.0
var has_candy:bool = false
var is_touched_by_teacher : bool = false # not yet
var back_to_safetyroom : bool = false
var nb_candy : int = 0
var safety_line : float = 10. # position x of the edge of the safety room


# for wove randomly
var current_position:Vector2
var target_position:Vector2

# for walk long way around
var center_position:Vector2
var angle:float = 0.0
var angle_speed :float = 0.6
var rayon :float
var sens
var new_position

# for jumping
var jump_time: float = 0.0  # jumping timer
var jumping: bool = false 
var jump_height: float = 1  
var jump_duration: float = 0.5  
var position_y : float # position of object original

# for chill in safety room
var stay_time: float
var stay_timer : float = 0.0
var edge_chill_zone_front :float = 10.
var edge_chill_zone_back : float = 14.
var target_position_chill : Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = Vector2(position.x,position.z)
	current_position = start_position
	end_position = Vector2(candy.position.x,candy.position.z)
	center_position = (start_position+end_position)*0.5
	rayon = start_position.distance_to(end_position)*0.5
	
	position_y = position.y
	_sensRound()
	_randomTargetPosition()
	_stayTime()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match current_state:
		State.WALK_TO_TARGET:
			match walk_method:
				"walk_direct":
					_walkDirect(delta)
				"walk_random":
					_walkAleatoire(delta)
				"walk_around":
					new_position = Vector2(center_position.x+cos(angle)*rayon,center_position.y+sin(angle)*rayon)
					_walkAround(delta)
		State.RETURN_TO_SAFETY:
			match walk_method:
				"walk_around":
					new_position = Vector2(center_position.x+cos(angle)*rayon,center_position.y+sin(angle)*rayon)
					_walkAround(delta)
			_returnToSafety(delta)
		State.CHILLING:
			_chill(delta)
		State.IS_CAUGHT:
			_returnToSafety(delta)
	position.y = max(position.y, 0.5)

# for jumping
func _handle_jump(delta):
	if jump_time < jump_duration:
		# use sinus to simuler the jumping
		position.y = sin((jump_time / jump_duration) * PI) * jump_height+position_y
		jump_time += delta
	else:
		position.y = position_y
		jumping = false

# strategy 1 : walk straight
func _walkDirect(delta):
	var direction = (end_position-Vector2(position.x,position.z)).normalized()
	var offset = direction*speed*delta
	position.x +=offset.x
	position.z +=offset.y
	if(Vector2(position.x,position.z).distance_to(end_position)<1):
		has_candy = true
		jumping = true
		jump_time = 0.0
		end_position = Vector2(safety_line,position.z)
		current_state = State.RETURN_TO_SAFETY
	if(jumping):
		_handle_jump(delta)


func _randomTargetPosition():
	var dirc_to_end = (end_position-Vector2(position.x, position.z)).normalized()
	var random_offset = Vector2(randf() * 2 - 1, randf() * 2 - 1)
	target_position = current_position+dirc_to_end*1.5+random_offset*5
	target_position.x = clamp(target_position.x, edge_left_back, edge_right_front)
	target_position.y = clamp(target_position.y, edge_left_back, edge_right_front)

# strategy 2 : walk randomly
func _walkAleatoire(delta):
	var direction = (target_position-current_position).normalized()
	var offset = direction*speed*delta
	current_position+=offset
	position.x += offset.x
	position.z += offset.y
	if(current_position.distance_to(target_position)<0.1):
		_randomTargetPosition()
	if(Vector2(position.x,position.z).distance_to(end_position)<1):
		has_candy = true
		jumping = true
		jump_time = 0.0  
		end_position = Vector2(safety_line,position.z)
		current_state = State.RETURN_TO_SAFETY
	if jumping:
		_handle_jump(delta)


func _sensRound():
	if(randi()%2 ==0):
		sens = 1
	else:
		sens = -1


# strategy 3 : walk round
func _initAround():
	end_position = Vector2(candy.position.x,candy.position.z)
	start_position = Vector2(position.x,position.z)
	center_position = (start_position+end_position)*0.5
	rayon = start_position.distance_to(end_position)*0.5
	#angle = 0.0
	var relative_position = Vector2(position.x, position.z) - center_position
	angle = atan2(relative_position.y, relative_position.x)

func _walkAround(delta):
	angle+=delta*angle_speed*sens
	new_position.x = clampf(new_position.x,edge_left_back,edge_right_front)
	new_position.y = clampf(new_position.y,edge_left_back,edge_right_front)
	position.x = new_position.x
	position.z = new_position.y
	if(Vector2(position.x,position.z).distance_to(end_position)<1):
		has_candy = true
		jumping = true
		jump_time = 0.0
		end_position = Vector2(safety_line,position.z)
		current_state = State.RETURN_TO_SAFETY
	if(jumping):
		_handle_jump(delta)


# back to the safety room
func _returnToSafety(delta):
	var direction = (end_position-Vector2(position.x,position.z)).normalized()
	var offset = direction*speed*delta
	position.x += offset.x
	position.z += offset.y
	if jumping:
		_handle_jump(delta)
	if(Vector2(position.x,position.z).distance_to(end_position)<0.1):
		current_position = Vector2(position.x, position.z)
		_stayTime()
		stay_timer=0.0
		_randomCHill()
		current_state = State.CHILLING

# been caught

func isCaught(): 
	return current_state == State.IS_CAUGHT or current_state == State.CHILLING
	
	
func _toSafeZone(delta) -> void:
	var waitTime = 10
	position.x = safety_line
	end_position = Vector2(safety_line+5,position.z)

func catch(delta):
	current_state = State.IS_CAUGHT
	end_position = Vector2(safety_line,position.z)
	var material = mesh_instance_3d.material_override
	material.albedo_color = color_map["sad"]
	_toSafeZone(delta)
# move in the safety room
func _stayTime():
	stay_time = randf_range(1.0,10.0)

func _randomCHill():
	var random_offset = Vector2(randf() * 2 - 1, randf() * 2 - 1)
	target_position_chill = Vector2(position.x,position.z)+random_offset*5
	target_position_chill.x = clamp(target_position_chill.x, edge_chill_zone_front, edge_chill_zone_back)
	target_position_chill.y = clamp(target_position_chill.y, edge_left_back, edge_right_front)

func _chill(delta):
	_uploadColor()
	stay_timer+=delta
	if(stay_timer<stay_time):
		if(Vector2(position.x,position.z).distance_to(target_position_chill)<0.1):
			current_position = Vector2(position.x, position.z)
			_randomCHill()
		else:
			var direction = (target_position_chill - Vector2(position.x, position.z)).normalized()
			var offset = direction * speed * delta
			position.x += offset.x
			position.z += offset.y
	else:
		current_position = Vector2(position.x, position.z)
		
		_initAround()
		_randomTargetPosition()
		_sensRound()
		current_state = State.WALK_TO_TARGET

func _set_walk_method(method):
	walk_method = method
	_uploadColor()

func _uploadColor():
	if walk_method in color_map:
		var material = mesh_instance_3d.material_override
		if material == null:
			material = StandardMaterial3D.new()
			mesh_instance_3d.material_override = material
		material.albedo_color = color_map[walk_method]
