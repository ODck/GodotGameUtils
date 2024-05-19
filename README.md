## Introduction
This repository contains tools that can be useful for Godot developers:
You can add the classes manually to Autoload, or activating the plugin in the plugins tab

* **Logger**: a simple logger class that allows you to log messages from your game or application.  
* **DiContainer**: a dependency injection container that makes it easy to manage dependencies between objects.  
* **SignalBus**: a signal bus class that allows you to send signals between objects without having to manually wire them up.
## Using the Logger
The Logger class is a simple way to log messages from your game or application. You can use it to debug issues, track events, or just provide information to the user. To use the logger,you need configure the logger to output logs to different places, such as the console, a file, or even a custom implementation. Extending BaseSink.

```gdscript
Logger.add_sink(Console.new())
```

 and then call one of the logging methods such as log, info, warning, or error. For example:

```gdscript
Logger.info("Starting game");
```

## Using the DiContainer
The DiContainer class is a dependency injection container that makes it easy to manage dependencies between objects. It allows you to decouple objects from their dependencies, making it easier to test and maintain your code.

### Features

- Register and retrieve singleton objects by name.
- Automatically inject dependencies into objects that implement an `_inject` method.
- Initialize registered singletons with an optional `_initialize` method.
- Process registered singletons with an optional `_tick` method.

### Usage
To use the DiContainer, register the dependencies that your objects need. For example:

#### 1. Registering Singletons
To register a singleton object, use the `register_singleton` or `register_singleton_node` method:

```gdscript
# create a di_init.gd script

# Register a singleton object
DiContainer.register_singleton("SomeClass", SomeClass.new())

# Register a singleton Node
DiContainer.register_singleton_node("SomeNode", SomeNode.new())
```

#### 2. Retrieving Singletons
To retrieve a singleton object by its name, use the resolveSingleton method:

When you want to create an object that needs a dependency, you can ask the container for an instance of the dependency instead of creating it yourself. For example:

```gdscript
# if a registered dependency needs to inject another dependency, add a _inject func in the script and they will be injected as well

func _inject():
	someObject = DiContainer.resolveSingleton("SomeClass")
```
The get method will return an instance of MyObject with a reference to the 

#### 3. Init and Process
If the dependency needs to call `_init`, and `_process` methods, just add `_initialize` and `tick` methods, and the DiContainer will handle

### Example
Here's a simple example demonstrating the usage of DiContainer:

```gdscript
# di_init.gd

func _ready():
    # Add console sink for logging
    Logger.add_sink(Logger.Console.new())
    
    # Register a singleton class
    DiContainer.register_singleton("SomeClass", SomeClass.new())
    
    # Initialize registered singletons
    DiContainer.initialize()
```

```gdscript
# test.gd

func _inject():
    # Inject dependencies
    _some_class = DiContainer.resolveSingleton("SomeClass")
```

```gdscript
#some_class.gd

func _tick(delta):
    # Process singleton objects
```

## Using the SignalBus
The SignalBus class is a signal bus that allows you to send signals between objects without having to manually wire them up. It's a great way to decouple objects from each other and make your code more modular.

```gdscript
SignalBus.subscribe("PLAYER", _do_something)
SignalBus.subscribe("PLAYER", _do_something_extra)
SignalBus.publish("PLAYER")
SignalBus.publish("PLAYER", ["extra"])
SignalBus.publish("PLAYER", ["extra", 2])
SignalBus.unsubscribe("PLAYER", _do_something)


# Define a function to subscribe to a signal
func _do_something():
    print("Received signal")

func _do_something_extra(arg0):
    print("Received signal with arguments")
```

You can also disconnect objects using the unsubscribe method.

## Contributing
Pull requests are welcome! If you have any bug fixes, feature requests, or improvements, feel free to contribute to this project.

## License
This project is licensed under the MIT license. See the LICENSE file for details.