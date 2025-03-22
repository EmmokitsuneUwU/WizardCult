extends StaticBody2D

var texture : Texture2D = load("res://Assets/Sprites/Rock.png")
var unitName = "Rock"
var maxHealth = 100
var health = 100
var selected = false
@export var wizard : bool = false

func _process(_delta: float) -> void:
	$SelectionIndicator.visible = selected
	if(health < 1):
		$Sprite2D.visible = false
		$StoneRunOut.visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Unit") and !body.is_in_group("Animal")):
		body.taskTarget = self
		body.changeTask("Rock Mining")
