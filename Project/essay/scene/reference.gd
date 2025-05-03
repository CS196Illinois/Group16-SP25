extends Sprite2D


func _on_button_book_pressed() -> void:
	texture = load("res://book.PNG")


func _on_button_film_pressed() -> void:
	texture = load("res://film.PNG")


func _on_button_photo_pressed() -> void:
	texture = load("res://photo.PNG")
	


func _on_button_clear_pressed() -> void:
	texture = null
