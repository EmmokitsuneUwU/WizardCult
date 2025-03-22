extends Camera2D

const SPEED = 600
var velocity = Vector2.ZERO

func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	if(Input.is_action_pressed("cam_up")):
		velocity.y = SPEED *-1

	if(Input.is_action_pressed("cam_left")):
		velocity.x = -SPEED
		
	if(Input.is_action_pressed("cam_right")):
		velocity.x = SPEED
		
	if(Input.is_action_pressed("cam_down")):
		velocity.y = SPEED
		
	if(Input.is_action_just_pressed("cam_zoom_in")):
		if(zoom < Vector2(3,3)):
			zoom += Vector2(0.5,0.5)
	if(Input.is_action_just_pressed("cam_zoom_out")):
		if(zoom > Vector2(0.3,0.3) ):
			zoom -=  Vector2(0.5,0.5)
		
	position += velocity * delta
