extends CharacterBody2D
class_name Player

#region Player Variables

@onready var Sprite = $Character1
@onready var Collider = $CollisionShape2D
@onready var Animator = $Animator
@onready var Camera = $Camera
@onready var States =$StateMachine
@onready var JumpBufferTimer = $Timers/JumpBuffer
@onready var CoyoteTimer = $Timers/CoyoteTimer

const RunSpeed := 180
const Acceleration := 40
const Deceleration := 15
const GravityJump := 350
const GravityFall := 600
const JumpVelocity := -200
const VariableJumpMultiplier = 0.7
const MaxJumps := 1
const JumpBufferTime = 0.15
const CoyoteTime = 0.1

var MoveSpeed = RunSpeed
var JumpSpeed = JumpVelocity
var MoveDirectionX = 0
var Jumps = 0
var Facing = 1

var Up := false
var Down := false
var Left := false
var Right := false
var Jump := false
var JumpPressed := false

var CurrentState = null
var PreviousState = null

#endregion

#region Main Loop Function
func _ready():
	GameManager.player = self
	for state in States.get_children():
		state.States = States
		state.Player = self
		PreviousState = States.Fall
		CurrentState = States.Fall

func _draw():
	CurrentState.Draw()

func _physics_process(delta: float) -> void:
	GetInputStates()
	
	CurrentState.Update(delta)
	
	HorizontalMovement()
	HandleJump()
	
	move_and_slide()
	
	if position.y >= 450:
		die()

func ChangeState(newState):
	if (newState != null):
		PreviousState = CurrentState
		CurrentState = newState
		PreviousState.ExitState()
		CurrentState	.EnterState()
		return

#endregion

#region Custom Functions

func GetInputStates():
	Up = Input.is_action_pressed("up")
	Down = Input.is_action_pressed("down")
	Left = Input.is_action_pressed("left")
	Right = Input.is_action_pressed("right")
	Jump = Input.is_action_pressed("jump")
	JumpPressed = Input.is_action_just_pressed("jump")
	
	if (Right): Facing = 1
	if (Left): Facing = -1


func HorizontalMovement(acceleration: float = Acceleration, deceleration: float = Deceleration):
	MoveDirectionX = Input.get_axis("left", "right")
	if (MoveDirectionX != 0):
		velocity.x = move_toward(velocity.x, MoveDirectionX * MoveSpeed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, MoveDirectionX * MoveSpeed, deceleration)

func HandleFalling():
	if(!is_on_floor()):
		CoyoteTimer.start(CoyoteTime)
		ChangeState(States.Fall)

func HandleJumpBuffer():
	if (JumpPressed):
		JumpBufferTimer.start(JumpBufferTime)

func HandleLanding():
	if(is_on_floor()):
		Jumps = 0
		ChangeState(States.Idle)

func HandleGravity(delta, gravity: float = GravityJump):
	if (!is_on_floor()):
		velocity.y += gravity * delta

func HandleJump():
	if (is_on_floor()):
		if((Jumps < MaxJumps) or (JumpBufferTimer.time_left > 0)):
			if(JumpPressed):
				Jumps += 1
				JumpBufferTimer.stop()
				ChangeState(States.Jump)
	else:
		if((Jumps < MaxJumps) and (Jumps > 0) and JumpPressed):
			Jumps += 1
			ChangeState(States.Jump)
		if(CoyoteTimer.time_left > 0):
			if((JumpPressed) and (Jumps < MaxJumps)):
				CoyoteTimer.stop()
				Jumps += 1
				ChangeState(States.Jump)

func HandelFlipH():
	Sprite.flip_h = (Facing < 1)

func die() :
	GameManager.respawn_player()

func bounce():
	velocity.y = -130  # bounce upward when killing enemy

#endregion
