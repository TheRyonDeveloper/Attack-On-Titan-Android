extends Node3D

const PLAYER_SPEED: float = 6.0
const GRAVITY: float = 18.0

@onready var player: CharacterBody3D = $Player

func _physics_process(delta: float) -> void:
    if not is_instance_valid(player):
        return

    if not player.is_on_floor():
        player.velocity.y -= GRAVITY * delta
    elif player.velocity.y < 0.0:
        player.velocity.y = 0.0

    var input_dir := Vector2.ZERO

    input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

    var direction := Vector3(input_dir.x, 0.0, input_dir.y).normalized()

    player.velocity.x = direction.x * PLAYER_SPEED
    player.velocity.z = direction.z * PLAYER_SPEED

    player.move_and_slide()
