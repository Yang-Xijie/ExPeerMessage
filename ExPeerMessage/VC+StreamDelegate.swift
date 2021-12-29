import Foundation

extension ViewController: StreamDelegate {
    /// called when stream has an event
    ///
    /// combined with MultipeerConnectivity, it holds the receiving procedure
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
//        print("Enter StreamDelegate")
        switch eventCode {
        case Stream.Event.hasBytesAvailable:
            if SpeedExperiment.isEnable == false {
                let input = aStream as! InputStream
                var buffer = [UInt8](repeating: 0, count: 1024) // allocate a buffer. The size of the buffer will depend on the size of the data you are sending.
                input.read(&buffer, maxLength: 1024)

                if let string = String(bytes: buffer, encoding: .utf8) {
                    self.chatView.text = self.chatView.text + string + "\n"
                } else {
                    print("not a valid UTF-8 sequence")
                }
            }
        case Stream.Event.hasSpaceAvailable:
            break
        default:
            break
        }
    }
}
