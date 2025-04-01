import CoreAudio
import AudioToolbox

func setAudioInputDevice(preferredDevices: [String]) {
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDevices,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    
    var deviceListSize: UInt32 = 0
    let systemObjectID = AudioObjectID(kAudioObjectSystemObject)
    
    guard AudioObjectGetPropertyDataSize(
        systemObjectID,
        &address,
        0,
        nil,
        &deviceListSize
    ) == noErr else {
        print("Failed to get device list size")
        return
    }
    
    let deviceCount = Int(deviceListSize / UInt32(MemoryLayout<AudioObjectID>.size))
    var deviceIDs = [AudioObjectID](repeating: 0, count: deviceCount)
    
    guard AudioObjectGetPropertyData(
        systemObjectID,
        &address,
        0,
        nil,
        &deviceListSize,
        &deviceIDs
    ) == noErr else {
        print("Failed to get device list")
        return
    }
    
    func findDevice(named deviceName: String) -> AudioObjectID? {
        for deviceID in deviceIDs {
            var nameSize = UInt32(MemoryLayout<CFString?>.size)
            var deviceNameCFString: CFString? = nil
            var deviceNameAddress = AudioObjectPropertyAddress(
                mSelector: kAudioDevicePropertyDeviceNameCFString,
                mScope: kAudioObjectPropertyScopeGlobal,
                mElement: kAudioObjectPropertyElementMain
            )
            
            let result = withUnsafeMutablePointer(to: &deviceNameCFString) { namePointer in
                namePointer.withMemoryRebound(to: Optional<CFString>.self, capacity: 1) {
                    AudioObjectGetPropertyData(
                        deviceID,
                        &deviceNameAddress,
                        0,
                        nil,
                        &nameSize,
                        $0
                    )
                }
            }
            
            if result == noErr,
               let deviceNameCFString = deviceNameCFString,
               (deviceNameCFString as String).caseInsensitiveCompare(deviceName) == .orderedSame {
                return deviceID
            }
        }
        return nil
    }
    
    for device in preferredDevices {
        if let deviceID = findDevice(named: device) {
            setDefaultInputDevice(to: deviceID)
            print("Set input device to \(device)")
            return
        }
    }
    
    print("None of the specified devices were found: \(preferredDevices.joined(separator: ", "))")
}


func setDefaultInputDevice(to deviceID: AudioObjectID) {
    var inputAddress = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDefaultInputDevice,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    var defaultDeviceID = deviceID
    let result = AudioObjectSetPropertyData(
        AudioObjectID(kAudioObjectSystemObject),
        &inputAddress,
        0,
        nil,
        UInt32(MemoryLayout<AudioObjectID>.size),
        &defaultDeviceID
    )
    if result != noErr {
        print("Failed to set default input device")
    }
}


