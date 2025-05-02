extends PlayerState

func EnterState():
	Name = "Fall"

func ExitState():
	pass


func Update(delta: float):
	Player.HandleGravity(delta, Player.GravityFall)
	Player.HorizontalMovement()
	Player.HandleLanding()
	Player.HandleJump()
	Player.HandleJumpBuffer()
	HandleAnimations()


func HandleAnimations():
	Player.Animator.play("fall")
	Player.HandelFlipH()
