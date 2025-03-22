extends CharacterBody2D

const SPEED = 8600.0
var selected : bool = false
var shouldMove : bool = false

var maxHealth = 100
var health = 0

var wood = 0
var maxWood = 10
var rock = 0
var maxRock = 10
var food = 0
var maxFood = 10

var texture : Texture2D = load("res://Assets/Sprites/Mage.png")

var woodCutterTexture : Texture2D = load("res://Assets/Sprites/MageWoodCutter.png")
var NormalTexture : Texture2D = load("res://Assets/Sprites/Mage.png")

var unitName = "Wizard"

var task = "None"
var taskTarget : StaticBody2D
var townCenter : StaticBody2D

@onready var navAgent : NavigationAgent2D = $NavigationAgent2D
@export var wizard : bool = true

func _ready() -> void:
	health = maxHealth
	navAgent.target_position = global_position
	changeTask("None")
	
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
	
	if(selected):
		ImguiDebug.health = health
		ImguiDebug.maxhealth = maxHealth
		ImguiDebug.wood = wood
		ImguiDebug.maxwood = maxWood
		ImguiDebug.rock = rock
		ImguiDebug.maxrock = maxRock
		ImguiDebug.food = food
		ImguiDebug.maxfood = maxFood
		ImguiDebug.task = task
		ImguiDebug.shouldMove = shouldMove

func changeTask(NewTask : String):
	task = NewTask
	match task:
		"None":
			texture = NormalTexture
			$Sprite2D.texture = NormalTexture
			pass
		"Wood Cutting":
			print("Im " + self.name + " im going to cut wood")
			texture = woodCutterTexture
			$Sprite2D.texture = woodCutterTexture
			
			if(taskTarget):
				if(global_position.distance_to(taskTarget.global_position)):
					$PickUpTimer.start()
		"Rock Mining":
			print("Im " + self.name + " im going to mine rock")
			texture = woodCutterTexture
			$Sprite2D.texture = woodCutterTexture
			
			if(taskTarget):
				if(global_position.distance_to(taskTarget.global_position)):
					$PickUpTimer.start()
		"Fruit Gathering":
			print("Im " + self.name + " im going to gather food")
			texture = woodCutterTexture
			$Sprite2D.texture = woodCutterTexture
			
			if(taskTarget):
				if(global_position.distance_to(taskTarget.global_position)):
					$PickUpTimer.start()

func usrMove(Location : Vector2):
	changeTask("None")
	phFMove(Location)

func phFMove(Location : Vector2):
	shouldMove = true
	navAgent.target_position = Location
	print("Im " + self.name + " OK, I'm moving to: " + str(Location))

func _on_navigation_agent_2d_navigation_finished() -> void:
	shouldMove = false

func resumeTask():
	match task:
		"None":
			print("wtf...")
			pass
		"Wood Cutting":
			phFMove(taskTarget.global_position)
		"Rock Mining":
			phFMove(taskTarget.global_position)
		"Fruit Gathering":
			phFMove(taskTarget.global_position)

func _on_pick_up_timer_timeout() -> void:
	match task:
		"None":
			print("wtf...")
			pass
		"Wood Cutting":
			if(wood <  maxWood and taskTarget.health > 0):
				wood += 1
				taskTarget.health -= 1
				print("Im " + self.name +" i picked up some wood")
				$PickUpTimer.start()
			else:
				phFMove(townCenter.global_position)
		"Rock Mining":
			if(rock <  maxRock and taskTarget.health > 0):
				rock += 1
				taskTarget.health -= 1
				print("Im " + self.name +" i picked up some rock")
				$PickUpTimer.start()
			else:
				phFMove(townCenter.global_position)
		"Fruit Gathering":
			if(food <  maxFood and taskTarget.health > 0):
				food += 1
				taskTarget.health -= 1
				print("Im " + self.name +" i picked gather up some food")
				$PickUpTimer.start()
			else:
				phFMove(townCenter.global_position)
