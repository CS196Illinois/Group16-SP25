extends PlayerState

func EnterState():
	Name = "Jump"
	Player.velocity.y = Player.JumpSpeed

func ExitState():
	pass


func Update(delta: float):
	Player.HandleGravity(delta)
	Player.HorizontalMovement()
	HandleJumpToFall()
	HandleAnimations()

func HandleJumpToFall():
	if (Player.velocity.y >= 0):
		Player.ChangeState(States.Fall)
	if (!Player.Jump):
		Player.velocity.y *= Player.VariableJumpMultiplier
		Player.ChangeState(States.Fall)

func HandleAnimations():
	Player.Animator.play("jump")
	Player.HandelFlipH()
