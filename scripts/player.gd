extends CharacterBody2D

const SPEED = 300
var tileMap
var targetPos
var moving

@onready var upRayCast = $CollisionShape2D/UpRayCast
@onready var leftRayCast = $CollisionShape2D/LeftRayCast
@onready var rightRayCast = $CollisionShape2D/RightRayCast
@onready var downRayCast = $CollisionShape2D/DownRayCast

func _ready():
	tileMap = get_node("../Map")
	position = tileMap.to_global(tileMap.map_to_local(Vector2()))
	targetPos = position
	moving = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("hey")
			
	elif event is InputEventKey and !moving:
		var inputDir = Vector2()
		if event.keycode  == KEY_W and event.pressed and !upRayCast.is_colliding():
			inputDir = Vector2.UP
		if event.keycode  == KEY_A and event.pressed and !leftRayCast.is_colliding():
			inputDir = Vector2.LEFT
		if event.keycode  == KEY_S and event.pressed and !downRayCast.is_colliding():
			inputDir = Vector2.DOWN
		if event.keycode  == KEY_D and event.pressed and !rightRayCast.is_colliding():
			inputDir = Vector2.RIGHT
		calculateTargetPos(inputDir)

func calculateTargetPos(inputDir):
	var currentGridPos = tileMap.local_to_map(tileMap.to_local(position))
	var newGridPos = Vector2(currentGridPos) + inputDir
	targetPos = tileMap.to_global(tileMap.map_to_local(newGridPos))

func _physics_process(delta):	
	if position.distance_to(targetPos) > 3:
		moving = true
		var moveDir = (targetPos - position).normalized()
		velocity = moveDir * SPEED
		#move_and_collide(moveDir * delta * SPEED)
		move_and_slide()
	else: 
		moving = false
		position = targetPos
