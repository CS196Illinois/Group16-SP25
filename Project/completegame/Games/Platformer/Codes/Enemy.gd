extends CharacterBody2D


var speed = -30.0
var facing_right = false

func _ready():
	$AnimationPlayer.play("walk")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
	
	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_hitbox_area_entered(area: Area2D):
	if area.get_parent() is Players:
		if area.get_parent().global_position.y < $Hitbox.global_position.y - 10:
			area.get_parent().bounce()
			die()
		else:
			area.get_parent().die()

func die():
	queue_free()
