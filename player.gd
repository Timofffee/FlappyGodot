extends RigidBody2D

var i = 0

func _ready():
	set_process(true)
	

func _process(delta):
	if not is_sleeping() and get_tree().get_current_scene().is_playing():
		if (get_pos().y > 0):
			if (Input.is_action_just_pressed("ui_accept")):
				set_linear_velocity(Vector2(0,-350))
	else:
		if (Input.is_action_just_pressed("ui_accept") and get_tree().get_current_scene().has_restart()):
			get_tree().change_scene("res://main.tscn")
	
		
	get_node("Sprite").set_rot(Vector2(-750,0).angle_to_point(get_linear_velocity())+deg2rad(90))
