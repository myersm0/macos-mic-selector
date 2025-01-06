## macos-mic-defaults
On Mac OS, this allows you to set your audio input device from the command line according to defaults that you specify (specifically, a primary device and a fallback).

Useful in the event of a bluetooth device that likes to become the active audio input device by default every time it connects to your Mac, like AirPods. This way you can automate overriding that behavior.

## Installation
From the command line:
```
swiftc AudioDeviceManager.swift main.swift -o set_mic_defaults
```

## Usage
Replace the two input arguments according to the actual names of the mics that you want to use:
```
set_mic_defaults "Samson Q9U" "MacBook Pro Microphone"
```

Or if you only have one device that you want to use, without a fallback:
```
set_mic_defaults "MacBook Pro Microphone"
```





