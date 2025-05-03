extends Control

@onready var score_label = $Score
	
var score : int:
	set(value):
		score_label.text = "Score: " + str(value)
