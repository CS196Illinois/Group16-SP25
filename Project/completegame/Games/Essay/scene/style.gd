extends Sprite2D


func _on_narrative_pressed() -> void:
	texture = load("res://narrative.PNG")


func _on_argumentative_pressed() -> void:
	texture = load("res://argumentative.PNG")
	


func _on_button_clear_pressed() -> void:
	texture = null
