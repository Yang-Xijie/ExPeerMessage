// SpeedTest.swift

import Foundation

struct SpeedExperiment {
    static let bytesPerTransmission: Int = 10000 // B

    static let testString = String(repeating: "*", count: bytesPerTransmission)

    static let expectedSpeed: Float = 100_000_000.0 // B/s

    // test in 5 seconds
    static let experimentTime: Float = 5 // s

    static let experimentTimes = Int(experimentTime * expectedSpeed / Float(bytesPerTransmission))

    static let interval = TimeInterval(Float(bytesPerTransmission) / expectedSpeed)

    static let isEnable = true
}

// Test Method:
// 1. set `SpeedExperiment.isEnable` to true
// 2. launch the app on two divices
// 3. create the connection and create the stream
// 4. test the stream speed and observe results in Xcode Debug Navigator (cmd+7)

// RESULTS: Regardless of IO processing, speed reaches 20 MB/s around between a simulator on Macbook Pro and an iPad Pro (connected to the same AP). When closing the wifi, speed reaches 12MB/s. It has the ability to support much services.

// NOTICE: `encryptionPreference: .required` will need 3 times of speed
