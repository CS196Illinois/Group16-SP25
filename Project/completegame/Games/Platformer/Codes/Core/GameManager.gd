extends Node

class_name GameManager

static var current_checkpoint : Checkpoint

static var player : Players


static func respawn_player() :
	if current_checkpoint != null :
		player.position = current_checkpoint.global_position
