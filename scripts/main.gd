extends Node3D

const WALK_SPEED: float = 6.0
const ODM_SPEED: float = 12.0
const JUMP_VELOCITY: float = 7.0
const GRAVITY: float = 18.0

@onready var player: CharacterBody3D = $Player
@onready var hud = $HUD

var odm_enabled: bool = false
var attack_count: int = 0

func _ready() -> void:
    hud.jump_requested.connect(_on_jump_requested)
    hud.attack_requested.connect(_on_attack_requested)
    hud.odm_toggled.connect(_on_odm_toggled)

func _physics_process(delta: float) -> void:
    if not player.is_on_floor():
        player.velocity.y -= GRAVITY * delta
    elif player.velocity.y < 0.0:
        player.velocity.y = 0.0

    var input_dir := Vector2.ZERO
    input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

    input_dir = input_dir.normalized()

    var speed: float = ODM_SPEED if odm_enabled else WALK_SPEED

    player.velocity.x = input_dir.x * speed
    player.velocity.z = input_dir.y * speed

    player.move_and_slide()

func _on_jump_requested() -> void:
    if player.is_on_floor():
        player.velocity.y = JUMP_VELOCITY

func _on_attack_requested() -> void:
    attack_count += 1
    hud.get_node("Controls/Instructions").text = "ATTACK COUNT: " + str(attack_count)

func _on_odm_toggled(enabled: bool) -> void:
    odm_enabled = enabled
