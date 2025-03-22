extends Node

@export var GUI : Control
@export var Cursor : Area2D

@onready var element1texture := preload("res://Assets/Structures/SilkscreenTest.png")
@onready var element2texture := preload("res://Assets/Structures/SilkscreenTest2.png")

func _on_close_pressed() -> void:
	GUI.get_node("./BuildPanel").visible = false

func _on_texture_button_pressed() -> void:
	GUI.get_node("./BuildPanel").visible = true

func _on_element_1_pressed() -> void:
	Cursor.get_node("./SilkScreen").texture = element1texture

func _on_element_2_pressed() -> void:
	Cursor.get_node("./SilkScreen").texture = element2texture


func _on_element_3_pressed() -> void:
	pass # Replace with function body.


func _on_element_4_pressed() -> void:
	pass # Replace with function body.


func _on_element_5_pressed() -> void:
	pass # Replace with function body.


func _on_element_6_pressed() -> void:
	pass # Replace with function body.


func _on_element_7_pressed() -> void:
	pass # Replace with function body.


func _on_element_8_pressed() -> void:
	pass # Replace with function body.


func _on_element_9_pressed() -> void:
	pass # Replace with function body.


func _on_element_10_pressed() -> void:
	pass # Replace with function body.
