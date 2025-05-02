extends Node2D
class_name EndPoint

@export var spawnpoint = false
var victoried = false

func activate():
	play_success()
	victoried = true

func _on_area_2d_area_entered(area: Area2D):
	if area.get_parent() is Player && !victoried:
		activate()

func play_success():
	$AnimationPlayer.play("Victory")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://main_map.tscn")
