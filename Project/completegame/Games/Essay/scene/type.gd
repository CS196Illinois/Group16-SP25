extends Sprite2D


func _on_research_pressed() -> void:
	texture = load("res://Games/Essay/research.PNG")


func _on_essay_pressed() -> void:
	texture = load("res://Games/Essay/essay.PNG")
	


func _on_button_clear_pressed() -> void:
	texture = null
