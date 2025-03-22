extends Node2D

@onready var Cursor : Area2D = $Cursor
@onready var PingSprite : AnimatedSprite2D = $Cursor/Ping
var selectedUnit
var previousSelected

#UI Things
@onready var UnitTexture : TextureRect = $GUI/Control/BottomPanel/UnitImage/TextureRect
@onready var unitHealthIndicator : ProgressBar = $GUI/Control/BottomPanel/UnitData/VBoxContainer/UnitHealth
@onready var UnitWoodTexture : TextureRect = $GUI/Control/BottomPanel/UnitResources/VBoxContainer/Wood/TextureRect
@onready var UnitRockTexture : TextureRect = $GUI/Control/BottomPanel/UnitResources/VBoxContainer/Stone/TextureRect
@onready var UnitFoodTexture : TextureRect = $GUI/Control/BottomPanel/UnitResources/VBoxContainer/Food/TextureRect

@onready var unitNameIndicator : Label = $GUI/Control/BottomPanel/UnitData/VBoxContainer/UnitName
@onready var woodLabel : Label = $GUI/Control/BottomPanel/Resources/VBoxContainer/Wood/Label
@onready var stoneLabel : Label = $GUI/Control/BottomPanel/Resources/VBoxContainer/Stone/Label
@onready var foodLabel : Label = $GUI/Control/BottomPanel/Resources/VBoxContainer/Food/Label
@onready var unitWoodLabel : Label = $GUI/Control/BottomPanel/UnitResources/VBoxContainer/Wood/Label
@onready var unitRockLabel : Label = $GUI/Control/BottomPanel/UnitResources/VBoxContainer/Stone/Label
@onready var unitFoodLabel : Label = $GUI/Control/BottomPanel/UnitResources/VBoxContainer/Food/Label
@onready var unitTaskLabel : Label = $GUI/Control/BottomPanel/UnitData/VBoxContainer/Panel/Label

@export var townCenter : StaticBody2D

#Resources
var wood : int = 0
var stone : int = 0
var food : int = 0

func _process(_delta: float) -> void:
	
	woodLabel.text = str(wood)
	stoneLabel.text = str(stone)
	foodLabel.text = str(food)
	
	Cursor.position = get_global_mouse_position()
	
	if(Input.is_key_pressed(KEY_F11)):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	if(Input.is_action_just_pressed("ms_select")):
		if(selectedUnit != null and previousSelected == null):
				
			previousSelected = selectedUnit
			selectedUnit.selected = true
			
			if(selectedUnit.wizard):
				selectedUnit.townCenter = townCenter
				unitWoodLabel.text = str(selectedUnit.wood)
				unitRockLabel.text = str(selectedUnit.rock)
				unitFoodLabel.text = str(selectedUnit.food)
				unitTaskLabel.text = selectedUnit.task
			
			UnitTexture.texture = selectedUnit.texture
			unitNameIndicator.text = selectedUnit.unitName
			unitHealthIndicator.max_value = selectedUnit.maxHealth
			unitHealthIndicator.value = selectedUnit.health
			
		else:
			if(previousSelected != null):
				previousSelected.selected = false
			previousSelected = null
			
			UnitTexture.texture = null
			unitNameIndicator.text = ""
			unitHealthIndicator.max_value = 100
			unitHealthIndicator.value = 0
			
			unitWoodLabel.text = ""
			unitRockLabel.text = ""
			unitFoodLabel.text = ""
			unitTaskLabel.text = ""
			
	if(Input.is_action_just_pressed("ms_move")):
		if(previousSelected != null and previousSelected.is_in_group("UserMovable")):
			previousSelected.usrMove(get_global_mouse_position())
		PingSprite.play("Action")
	
func _on_cursor_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Unit") or body.is_in_group("Structure")):
		selectedUnit = body

func _on_cursor_body_exited(_body: Node2D) -> void:
	selectedUnit = null
