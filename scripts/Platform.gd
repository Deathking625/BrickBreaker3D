extends StaticBody

export var platform_speed = 6
export var platform_width = 2

var is_game_running = false
var current_level : int = 0
var balls_remaining = GameVariables.balls_remaining

onready var collision_shape = $CollisionShape
onready var mesh = $MeshInstance
onready var ball = get_node("../Ball")

func _ready():
	collision_shape.shape.extents.z = platform_width * 0.5
	mesh.mesh.size.z = platform_width


func _process(delta):
	if translation.z >= -4:
		translation.z -= Input.get_action_strength("Right") * delta * platform_speed
	else: translation.z = -4.001
	if translation.z <= 4:
		translation.z += Input.get_action_strength("Left") * delta * platform_speed
	else: translation.z = 4.001
	if !is_game_running and Input.is_action_just_pressed("Start") and balls_remaining > 0:
		start_game()


func start_game():
	is_game_running = true
	ball.start_game()


func end_game():
	is_game_running = false
