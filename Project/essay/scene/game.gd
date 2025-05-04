extends Node2D

var step := 0  # 控制现在是第几张图：0是p3，1是p4，2是p5
var selected_type := ""
var selected_style := ""
var selected_ref := ""

func _on_Buttonstart_pressed():
	# 清除旧内容
	$p3.visible = false
	$p4.visible = false
	$p5.visible = false
	$success.visible = false
	$fail.visible = false
	selected_type = ""
	selected_style = ""
	selected_ref = ""

	# 显示对应目标图片
	match step:
		0: $p3.visible = true
		1: $p4.visible = true
		2: $p5.visible = true
	step = (step + 1) % 3  # 下一轮循环
	


func _on_essay_pressed() -> void:
	selected_type = "essay"

func _on_research_pressed() -> void:
	selected_type = "research"

func _on_narrative_pressed() -> void:
	selected_style = "narrative"
func _on_argumentative_pressed() -> void:
	selected_style = "argumentative"

func _on_button_book_pressed() -> void:
	selected_ref = "book"
func _on_button_film_pressed() -> void:
	selected_ref = "film"
func _on_button_photo_pressed() -> void:
	selected_ref = "photo"
	
func _on_Buttonenter_pressed():
	var success_condition := false

	if $p3.visible:
		success_condition = selected_type == "essay" and selected_style == "narrative" and selected_ref == "book"
	elif $p4.visible:
		success_condition = selected_type == "essay" and selected_style == "argumentative" and selected_ref == "photo"
	elif $p5.visible:
		success_condition = selected_type == "research" and selected_style == "argumentative" and selected_ref == "film"

	if success_condition:
		$success.visible = true
	else:
		$fail.visible = true
		
func _on_success_pressed():
	#_reset_game()
	get_tree().change_scene_to_file("res://MainMap/main_map.tscn")

func _on_fail_pressed():
	_reset_game()

func _reset_game():
	$p3.visible = false
	$p4.visible = false
	$p5.visible = false
	$success.visible = false
	$fail.visible = false
	selected_type = ""
	selected_style = ""
	selected_ref = ""
