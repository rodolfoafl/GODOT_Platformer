extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 9.8

export (int) var maxSpeed = 200
export (int) var jumpHeight = 250
export (int) var acceleration = 50

var motion = Vector2()
var friction = false

func _physics_process(delta):
	motion.y += GRAVITY
	
	if(Input.is_action_pressed("ui_right")):
		motion.x += acceleration
	elif(Input.is_action_pressed("ui_left")):
		motion.x -= acceleration	
		
	if(is_on_floor()):
		if(Input.is_action_just_pressed("ui_up")):
			motion.y = -jumpHeight	
			
	_handle_Animation(motion)			
	
	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	motion = move_and_slide(motion, UP)	
#
func _handle_Animation(var velocity):
	if velocity.x != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.animation = "idle"
		friction = true
		
	if(!is_on_floor()):
		if(velocity.y < 0):
			$AnimatedSprite.animation = "jump"
		else:
			$AnimatedSprite.animation = "idle"
		if(friction):
			motion.x = lerp(motion.x, 0, 0.05)
	else:
		if(friction):
			motion.x = lerp(motion.x, 0, 0.25)

