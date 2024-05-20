extends Sprite2D

@export var ghost_time: float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.hex(0xffffff00), ghost_time)
	tween.tween_callback(queue_free)
