extends PlayerState

func EnterState():
	Name = "Run"

func ExitState():
	pass


func Update(delta: float):
	Player.HorizontalMovement()
	Player.HandleJump()
	Player.HandleFalling()
	HandleAnimations()
	HandleIdle()

func HandleAnimations():
	Player.Animator.play("RunFast")
	Player.HandelFlipH()

func HandleIdle():
	if (Player.MoveDirectionX == 0):
		Player.ChangeState(States.Idle)
