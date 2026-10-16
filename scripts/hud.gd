extends CanvasLayer

signal attack_requested
signal jump_requested
signal odm_toggled(enabled: bool)

var odm_enabled: bool = false

@onready var attack_button: Button = $Controls/AttackButton
@onready var jump_button: Button = $Controls/JumpButton
@onready var odm_button: Button = $Controls/ODMButton
@onready var instructions: Label = $Controls/Instructions

func _ready() -> void:
    attack_button.pressed.connect(_on_attack_pressed)
    jump_button.pressed.connect(_on_jump_pressed)
    odm_button.pressed.connect(_on_odm_pressed)

func _on_attack_pressed() -> void:
    instructions.text = "ATTACK REQUESTED"
    attack_requested.emit()

func _on_jump_pressed() -> void:
    jump_requested.emit()

func _on_odm_pressed() -> void:
    odm_enabled = not odm_enabled
    odm_button.text = "ODM ON" if odm_enabled else "ODM"
    instructions.text = "ODM BOOST ENABLED" if odm_enabled else "ODM BOOST DISABLED"
    odm_toggled.emit(odm_enabled)
