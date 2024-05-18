extends Node
## author: ODck
## license: MIT
## description: 
##   It allows you to subscribe to signals, unsubscribe from signals, and publish signals.

## Subscribes to a signal. If the signal already exists, it will be connected immediately.
## Otherwise, it will create a new user-defined signal and connect it.
func subscribe(signal_name: String, callable: Callable) -> void:
	if get_signal_list().has(signal_name):
		connect(signal_name, callable)
	else:
		add_user_signal(signal_name, callable.get_bound_arguments())
		connect(signal_name, callable)

## Unsubscribes from a signal.
func unsubscribe(signal_name: String, callable: Callable):
	if  is_connected(signal_name, callable):
		disconnect(signal_name, callable)
	else:
		Logger.error("Signal %s unsubscribe failed, subscribe the signal first" % signal_name)

## Publishes a signal with an optional array of arguments.
func _legacy_publish(signal_name: String, args: Array = []):
	if has_user_signal(signal_name):
		emit_signal(signal_name, args)
	else:
		Logger.warning("Signal %s published without subscribers" % signal_name)

# Publishes a signal with an optional array of arguments
func publish(signal_name: String, args: Array = []):
	if has_user_signal(signal_name):
		for subscriber in get_signal_connection_list(signal_name):
			var callable = subscriber.callable;
			var expected_arg_count = get_method_arg_count(callable)
			if expected_arg_count != args.size():
				Logger.warning("Signal %s expected %d arguments, but got %d for callable %s" % [signal_name, expected_arg_count, args.size(), callable])


		match args.size():
			0:
				emit_signal(signal_name)
			1:
				emit_signal(signal_name, args[0])
			2:
				emit_signal(signal_name, args[0], args[1])
			3:
				emit_signal(signal_name, args[0], args[1], args[2])
			4:
				emit_signal(signal_name, args[0], args[1], args[2], args[3])
			5:
				emit_signal(signal_name, args[0], args[1], args[2], args[3], args[4])
			6:
				emit_signal(signal_name, args[0], args[1], args[2], args[3], args[4], args[5])
			7:
				emit_signal(signal_name, args[0], args[1], args[2], args[3], args[4], args[5], args[6])
			8:
				emit_signal(signal_name, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7])
			# Add more cases if you expect more arguments
			_:
				emit_signal(signal_name, args)
	else:
		Logger.warning("Signal %s published without subscribers" % signal_name)


# Get the number of arguments expected by a callable
func get_method_arg_count(m: Callable):
	for f in m.get_object().get_method_list():
		var fn = get(f.name)
		if m.get_method() == f.name:
			return f.args.size()
	return 0
