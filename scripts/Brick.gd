extends StaticBody

export var destruction_level : int = 3

onready var mesh = $Mesh
onready var cracks1 = $Cracks1
onready var cracks2 = $Cracks2

func _ready():
	randomize()
	mesh.get_surface_material(0).albedo_color = Color(randf(), randf(), randf())
	cracks1.visible = false
	cracks2.visible = false


func is_hit():
	destruction_level -= 1
	GameVariables.game_score +=10
	if destruction_level == 2:
		cracks1.visible = true
		cracks2.visible = false
	elif destruction_level ==1:
		cracks2.visible = true
		cracks1.visible = false
	if destruction_level <= 0:
		queue_free()
		GameVariables.game_score += 20
		GameVariables.bricks_broken += 1
