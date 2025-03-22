extends CharacterBody2D

const SPEED = 7700.0
var selected : bool = false
var shouldMove : bool = false

var maxHealth = 100
var health = 0

var texture : Texture2D = load("res://Assets/Sprites/cow.png")
var unitName = "Cow"

@onready var navAgent : NavigationAgent2D = $NavigationAgent2D
@export var wizard : bool = false

func _ready() -> void:
	health = maxHealth
	navAgent.target_position = global_position

func _physics_process(delta: float) -> void:
	var direction = navAgent.get_next_path_position() - global_position
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	if shouldMove:
		velocity = direction * SPEED * delta
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _process(_delta: float) -> void:
	$SelectionIndicator.visible = selected

func phFMove(Location : Vector2):
	shouldMove = true
	navAgent.target_position = Location

func _on_navigation_agent_2d_navigation_finished() -> void:
	shouldMove = false
	$MoveTimer.start(randf_range(1,15))

func randomVectorInRadius(radius : float):
	var angle = randf_range(0, TAU)
	var distance = randf_range(0, radius)
	return Vector2.from_angle(angle) * distance

func _on_move_timer_timeout() -> void:
	phFMove(randomVectorInRadius(500))
