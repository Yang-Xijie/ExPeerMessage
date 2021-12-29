import Foundation

extension ViewController: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        print("Enter StreamDelegate")
        switch eventCode {
        case Stream.Event.hasBytesAvailable:
            let input = aStream as! InputStream
            var buffer = [UInt8](repeating: 0, count: 1024) // allocate a buffer. The size of the buffer will depended on the size of the data you are sending.
            input.read(&buffer, maxLength: 1024)
            print(buffer)

            if let string = String(bytes: buffer, encoding: .utf8) {
                print(string)
            } else {
                print("not a valid UTF-8 sequence")
            }

        // input
        case Stream.Event.hasSpaceAvailable:
            break
        // output
        default:
            break
        }
    }
}
