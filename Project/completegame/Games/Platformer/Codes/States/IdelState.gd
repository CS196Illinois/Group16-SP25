extends PlayerState


func EnterState():
	Name = "Idle"

func ExitState():
	pass

func Draw():
	pass

func Update(delta: float):
	Player.HandleFalling()
	Player.HandleJump()
	Player.HorizontalMovement()
	if(Player.MoveDirectionX != 0):
		Player.ChangeState(States.Run)
	HandleAnimations()


func HandleAnimations():
	Player.Animator.play("Idel")
	Player.HandelFlipH()
