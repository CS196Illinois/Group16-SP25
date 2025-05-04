extends Node2D
@export var enemy_scenes: Array[PackedScene] = []
@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen
@onready var pb = $ParallaxBackground

@onready var laser_sound = $SFX/LaserSound
@onready var hit_sound = $SFX/HitSound
@onready var explode_sound = $SFX/ExplodeSound

var player = null
var _score := 0
var score: int:
	get:
		return _score
	set(value):
		_score = value
		hud.score = _score
		
var scroll_speed = 150

func _ready():
	score = 0
	print("Viewport size: ", get_viewport_rect().size)
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)
	timer.timeout.connect(_on_enemy_spawn_timer_timeout)
	timer.start()
	
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	if timer.wait_time > 0.5:
		timer.wait_time -= delta * 0.005
	elif timer.wait_time < 0.5:
		timer.wait_time = 0.5
		
	pb.scroll_offset.y += delta*scroll_speed
		
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	laser_sound.play()

func _on_enemy_spawn_timer_timeout() -> void:
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 500), -50)
	print("Instantiated enemy node:", e)
	print("Class name:", e.get_class())
	print("Has method 'take_damage':", e.has_method("take_damage"))
	print("Has signal 'killed':", "killed" in e.get_signal_list().map(func(s): return s.name))
	print("Connected signals:")
	
	e.killed.connect(_on_enemy_killed)
	e.hit.connect(_on_enemy_hit)
	print("Signals connected to _on_enemy_killed and _on_enemy_hit")
	
	enemy_container.add_child(e)
	
func _on_enemy_killed():
	print("Signal received: Enemy killed")
	score += 100
	
func _on_enemy_hit():
	hit_sound.play()
	
func _on_player_killed():
	explode_sound.play()
	gos.set_score(score)
	await get_tree().create_timer(1.5).timeout
	gos.visible = true
