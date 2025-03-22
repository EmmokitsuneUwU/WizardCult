extends StaticBody2D

@export var sceneManager : Node2D

var texture : Texture2D = load("res://Assets/Sprites/TownCenter.png")
var unitName = "Town Center"
var maxHealth = 100
var health = 100
var selected = false
@export var wizard : bool = false

func _process(delta: float) -> void:
	$SelectionIndicator.visible = selected

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Unit") and !body.is_in_group("Animal")):
		sceneManager.wood += body.wood
		body.wood = 0
		sceneManager.stone += body.rock
		body.rock = 0
		sceneManager.food += body.food
		body.food = 0
		
		body.resumeTask()
