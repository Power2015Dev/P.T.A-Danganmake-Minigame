extends AudioStreamPlayer2D

var measures : int = 4

var sec_per_beat : float = 1.0
var song_position : float = 0.0
var song_beat_position : int = 0
var last_beat_reported : int = 0
var beats_before_start : int = 0
var measure : int = 1

signal next_beat(position)
signal next_measure(position)

func BPM(_bpm : float = 60.0) -> void:
	sec_per_beat = 60.0 / _bpm

func _process(_delta: float) -> void:
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_beat_position = int(floor(song_position / sec_per_beat)) + beats_before_start
		report_beats()
		
func report_beats() -> void:
	while last_beat_reported < song_beat_position:
		last_beat_reported += 1
		
		next_beat.emit(last_beat_reported)
		next_measure.emit(measure)
		
		measure += 1
		if measure > measures:
			measure = 1
