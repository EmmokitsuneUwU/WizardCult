extends Node

var health : int = 0
var maxhealth : int = 0
var wood : int = 0
var rock : int = 0
var food : int = 0
var maxwood : int = 0
var maxrock : int = 0
var maxfood : int = 0
var task : String = ""
var shouldMove : bool = false

func _process(_delta: float) -> void:
	ImGui.Begin("Debug")
	ImGui.Text("Selected Unit FULL Data")
	ImGui.Text("Health: " + str(health))
	ImGui.Text("Max Health: " + str(maxhealth))
	ImGui.Text("Wood: " + str(wood))
	ImGui.Text("Max Wood: " + str(maxwood))
	ImGui.Text("Rock: " + str(rock))
	ImGui.Text("Max Rock: " + str(maxrock))
	ImGui.Text("Food: " + str(food))
	ImGui.Text("Max Food: " + str(maxfood))
	ImGui.Text("Task: " + str(task))
	ImGui.Text("Should Move: " + str(shouldMove))
	ImGui.End()
