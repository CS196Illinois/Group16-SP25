class_name Enemy extends Area2D


signal killed
signal hit

@export var speed = 150
@export var hp = 3


func _physics_process(delta):
	global_position.y += speed * delta
	
func die():
	queue_free()

func _on_body_entered(body) -> void:
	if body is Player:
		body.die()
		die()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func take_damage(amount: int = 1):
	print("Enemy took damage, remaining hp before:", hp)
	hit.emit()
	hp -= amount
	if hp <= 0:
		killed.emit()
		die()
	
