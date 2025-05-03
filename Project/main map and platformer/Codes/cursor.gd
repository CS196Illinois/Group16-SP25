extends CharacterBody2D

const SPEED = 200
var current_location: Area2D = null

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * SPEED
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if current_location:
			enter_game()

func enter_game():
	if current_location:
		var game_name = current_location.get_meta("game_scene")
		get_tree().change_scene_to_file(game_name)


func _on_area_entered(area: Area2D):
	if area.is_in_group("game_locations"):
		current_location = area


func _on_area_exited(area: Area2D):
	if area == current_location:
		current_location = null
