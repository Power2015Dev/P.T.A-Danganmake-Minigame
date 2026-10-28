extends CanvasLayer

# HERE YOU CAN START CREATING YOUR MINIGAME
# WARNING: DO NOT USE OPERATING SYSTEM FUNCTIONS OR HTTP REQUESTS.

var input_Keys : Array = []

var persistent_state : bool = false

var bpm : float = 120.0
var measure : int = 4

@onready var music: AudioStreamPlayer2D = $Music

func _ready() -> void:
	# You can add your own input maps here.
	# Custom_key("move_forwards", KEY_W)
	# Custom_Mouse_key("shoot", MOUSE_BUTTON_LEFT)
	
	# if you make persistent_state = true
	# it wont' destroy the scene after you emit the Player_won signal
	# useful for HUD things that you want to make it stay 
	Start_Minigame({})
	pass

func Start_Minigame(param : Dictionary):
	# Don't declare start_minigame() in _ready 
	# unless you are testing the minigame itself.
	music.BPM(bpm)
	music.measures = measure
	music.last_beat_reported = 0
	music.measure = 1
	music.play()
	pass



func Win():
	# deleting the inputs you declared after win
	for actions in input_Keys:
		if InputMap.has_action(actions):
			InputMap.erase_action(actions)
	
	GlobalStates.Player_won.emit()
func Lose():
	GlobalStates.Player_lose.emit()

func Custom_key(action: String, key: Key) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
		var evento = InputEventKey.new()
		evento.keycode = key
		input_Keys.append(action)
		InputMap.action_add_event(action, evento)

func Custom_Mouse_key(action : String, MouseEvent: MouseButton) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
		var evento = InputEventMouseButton.new()
		evento.button_index = MouseEvent
		input_Keys.append(action)
		InputMap.action_add_event(action, evento)

func _exit_tree() -> void:
	for action in input_Keys:
		if InputMap.has_action(action):
			InputMap.erase_action(action)
	input_Keys.clear()


func _on_music_next_beat(position: Variant) -> void:
	GlobalSound.Load_SFX("testing")



func _on_music_next_measure(position: Variant) -> void:
	pass # Replace with function body.
