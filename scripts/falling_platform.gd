extends AnimatableBody2D
@onready var animation := $Animation as AnimationPlayer
@onready var respawntimer := $RespawnTimer as Timer
@onready var respawn_position := global_position

@export var resettimer := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var istriggered := false

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta

func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !istriggered:
		istriggered = true
		animation.play("shake")
		velocity = Vector2.ZERO


func _on_animation_animation_finished(anim_name: StringName) -> void:
	set_physics_process(true)
	respawntimer.start(resettimer)


func _on_respawn_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respawn_position
	if istriggered:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property($texture, "scale", Vector2(1,1), 0.2).from(Vector2(0,0))
	istriggered = false
