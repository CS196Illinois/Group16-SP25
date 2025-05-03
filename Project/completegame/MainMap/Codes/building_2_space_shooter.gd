extends Area2D

@export var game_scene: String = "res://Games/SpaceShooter/Scenes/game.tscn"

func _ready():
	add_to_group("game_locations")
	set_meta("game_scene", game_scene)
	connect("body_entered", Callable(get_parent().get_node("Cursor"), "_on_area_entered"))
	connect("body_exited", Callable(get_parent().get_node("Cursor"), "_on_area_exited"))
