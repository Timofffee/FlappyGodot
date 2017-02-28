extends Node2D

var current_scene

func new_pos():
	set_pos(Vector2(400,-randi()%300))

func _ready ():
	randomize()
	current_scene = get_tree().get_current_scene()
	set_process(true)

func _process(delta):
	if current_scene.is_playing() == true:
		set_pos(get_pos()-Vector2(400*delta/2,0))
	else:	get_node("anim").stop()

func _on_Area2D_body_enter( body ):
	current_scene.kill()

func _on_Area2D2_body_enter( body ):
	current_scene.add_score()
