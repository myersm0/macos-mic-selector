import Foundation

let candidates = Array(CommandLine.arguments.dropFirst())

guard !candidates.isEmpty else {
    print("Usage: ./setAudioDevice <device1> [<device2> ...]")
    exit(1)
}

setAudioInputDevice(preferredDevices: candidates)

