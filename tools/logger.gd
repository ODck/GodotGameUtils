extends Node
## author: ODck
## license: MIT
## description: 
## 	This is a logger class that allows you to log messages at different levels (DEBUG, INFO, WARNING, ERROR, EXCEPTION)
## 	It also supports multiple sinks, which can be added and removed dynamically


## Sinks are objects that handle the actual logging. They can be added to the logger using the `add_sink` function
var sinks: Array = []

enum Level {
	## Debug level logs are usually used for very detailed information during development
	DEBUG,
	## Info level logs are used for general information that should be known by developers and users
	INFO,
	## Warning level logs indicate potential problems or issues that should be addressed soon
	WARNING,
	## Error level logs indicate serious problems that should be fixed immediately
	ERROR,
	## Exception level logs are used for critical errors that cause the program to crash or behave unexpectedly
	EXCEPTION
}

## Adds a sink to the list of sinks and initializes it
func add_sink(sink: BaseSink):
	sinks.push_back(sink)
	sink.initialize()

## Initialize the logger. Does nothing for now
func _init():
	pass

## Logs a serialized message at the DEBUG level
func debug_serialized(message):
	if OS.is_debug_build():
		_log(Level.DEBUG, var_to_str(message))

## Logs a message at the DEBUG level
func debug(message):
	if OS.is_debug_build():
		_log(Level.DEBUG, message)

## Logs a message at the INFO level
func info(message):
	_log(Level.INFO, message)

## Logs a message at the WARNING level
func warning(message):
	_log(Level.WARNING, message)

## Logs a message at the ERROR level
func error(message):
	_log(Level.ERROR, message)

## Logs a message at the EXCEPTION level
func exception(message):
	_log(Level.EXCEPTION, message)

## Writes a log message to all registered sinks
func _log(level: Level, message):
	for sink in sinks:
		sink.write(level, message)

## Abstract base class for sinks. Provides a common interface for writing log messages
class BaseSink:
	
	## Returns a string representation of the log level
	func _get_level_string(level: Level) -> String:
		match(level):
			Level.DEBUG:
				return "DEBUG"
			Level.INFO:
				return "INFO"
			Level.WARNING:
				return "WARNING"
			Level.ERROR:
				return "ERROR"
			Level.EXCEPTION:
				return "EXCEPTION"
			_:
				return ""

	## Formats a log message according to the log level and message
	func _format_string(level: Level, message: String) -> String:
		return message

	## Initializes the sink
	func initialize() -> void:
		pass
	
	## Writes a log message to the sink
	func write(level: Level, message: String) -> void:
		pass

	## Cleans up resources when the sink is disposed
	func dispose() -> void:
		pass


## Concrete implementation of a sink that writes log messages to the console
class Console:
	extends BaseSink
	
	func time_format(time_in_ms : int) ->String:
		var ms = time_in_ms % 1000
		var time_in_sec = (time_in_ms - ms)/1000
		var seconds = time_in_sec%60
		var minutes = (time_in_sec/60)%60
		var hours = (time_in_sec/60)/60
		#returns a string with the format "HH:MM:SS:MS"
		return "%02d:%02d:%02d:%03d" % [hours, minutes, seconds, ms]

	## Formats the current time as a string in the format HH:MM:SS:MS
	func _format_string(level:Level, message: String) -> String:
		var msg = "[%s][%s] - %s" % [_get_level_string(level), time_format(Time.get_ticks_msec()), message]
		return msg
	
	func write(level, message: String) -> void:
		print(_format_string(level, message))
	
