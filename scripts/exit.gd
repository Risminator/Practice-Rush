extends Area2D

func _ready():
	Events.condition_satisfied.connect(_on_condition_satisfied)

func activate_exit():
	$CollisionShape2D.disabled = false
	$GPUParticles2D.amount = 16
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.hex(0xffffffff), 1)

func _on_condition_satisfied():
	activate_exit.call_deferred()


func _on_body_entered(_body):
	print("A")
	Global.go_to_next_level.call_deferred()
