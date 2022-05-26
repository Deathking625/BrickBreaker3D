extends KinematicBody

export var motion_angle : float = 0

var velocity = Vector2.ZERO
var ball_speed = 300
var position_on_platform : float = 0

onready var Platform = get_node("../Platform")

func _ready():
	GameVariables.balls_in_game += 1
	velocity = Vector2(cos(motion_angle), sin(motion_angle))


func _physics_process(delta):
	var is_game_running = Platform.is_game_running
	if !is_game_running:
		translation.z = Platform.translation.z + position_on_platform
		translation.y = 0.3
	else:
		var velocity3D = Vector3(0, velocity.x, velocity.y) * delta * ball_speed
# warning-ignore:return_value_discarded
		move_and_slide(velocity3D, Vector3.UP)
		if get_last_slide_collision() != null:
			var coll_angle = get_last_slide_collision().get_angle(Vector3.UP)
			if get_slide_collision(0).collider.name == "Platform":
				coll_angle =  ((translation.z - Platform.translation.z) / (Platform.platform_width * .5)) * (PI * 0.25)
			var coll_nor = Vector2(cos(coll_angle), sin(coll_angle))
			velocity = velocity.bounce(coll_nor)
		for i in range(get_slide_count()):
			var collider = get_slide_collision(i).collider
			if collider.has_method("is_hit"):
				collider.is_hit()
		if Input.is_action_just_pressed("ui_accept"):
			splitt()
	if translation.y <= -.5:
		end_game()



func start_game():
	pass


func end_game():
	GameVariables.balls_remaining -= 1
	queue_free()


func game_over():
	pass


func splitt():
	var BALL_SCENE = load("res://scenes/Ball.tscn")
	var ball1 = BALL_SCENE.instance()
	ball1.motion_angle = velocity.angle() + 0.1
	var ball2 = BALL_SCENE.instance()
	ball2.motion_angle = velocity.angle() - 0.1
	get_node("../").add_child(ball1)
	get_node("../").add_child(ball2)
	GameVariables.balls_remaining += 1
	queue_free()










