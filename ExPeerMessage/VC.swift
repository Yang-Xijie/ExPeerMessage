import MultipeerConnectivity
import UIKit

class ViewController: UIViewController {
    // MARK: - properties

    /// communicating with peers in the group
    var mcSession: MCSession!
    /// telling deveices around you that you are willing to join a group; handling the invitations from others
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    /// displaying others around you; inviting them to join the group by tapping their names
    var mcBrowserViewController: MCBrowserViewController!
    /// use in mcSession to support streaming
    var outputStream: OutputStream!

    // MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad()")

        setupHideKeyboardOnTap()

        // create a session
        mcSession = MCSession(peer: myID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self

        // tell devices around you that you are willing to join a group
        mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: myID, discoveryInfo: nil, serviceType: "ExPeerMessage")
        mcNearbyServiceAdvertiser.delegate = self
        mcNearbyServiceAdvertiser.startAdvertisingPeer()

        // configure mcBrowserViewController
        mcBrowserViewController = MCBrowserViewController(serviceType: "ExPeerMessage", session: self.mcSession)
        mcBrowserViewController.delegate = self
        mcBrowserViewController.maximumNumberOfPeers = 1
    }

    // MARK: - subviews

    var chatView: UITextView!
    var messageField: UITextField!
    var sendButton: UIButton!
    var connectionButton: UIButton!
    var streamCreateButton: UIButton!
    var streamSendButton: UIButton!

    override func loadView() {
        print("loadView()")

        // MARK: view

        view = {
            let view = UIView()
            view.backgroundColor = .cyan
            return view
        }()

        // MARK: textView

        chatView = {
            let textView = UITextView()
            textView.text = "Start your chat!"
            textView.textColor = .orange
            textView.textAlignment = .natural
            textView.isEditable = false
            textView.isSelectable = false
            textView.frame.size.width = 20
            return textView
        }()
        view.addSubview(chatView)

        // MARK: textField

        messageField = {
            let textField = UITextField()
            textField.placeholder = "Enter Message Here"
            textField.borderStyle = .roundedRect
            return textField
        }()
        view.addSubview(messageField)

        // MARK: sendButton

        sendButton = {
            let button = UIButton()
            button.addAction(
                UIAction { _ in
                    print("You tapped the button!")
                    if self.messageField.text != "" {
                        let message = self.messageField.text!
                        self.messageField.text = ""
                        self.chatView.text = self.chatView.text + "\n" + myID.displayName + ": " + message

                        let data = message.data(using: String.Encoding.utf8)
                        do {
                            try self.mcSession.send(data!, toPeers: self.mcSession.connectedPeers, with: .reliable)
                        } catch {
                            print("Error occurred when sending data.")
                        }
                    }
                }, for: .touchDown
            )
            button.configuration = {
                var config = UIButton.Configuration.tinted()
                config.buttonSize = .medium
                config.cornerStyle = .medium
                config.title = "Send"
                return config
            }()
            button.isEnabled = false
            return button
        }()
        view.addSubview(sendButton)

        // MARK: connectionButton

        connectionButton = {
            let button = UIButton()
            button.addAction(
                UIAction { _ in
                    print("connectionButton tapped")
                    // to invite others to join the room
                    self.present(self.mcBrowserViewController, animated: true, completion: nil)
                }, for: .touchDown
            )
            button.configuration = {
                var config = UIButton.Configuration.tinted()
                config.buttonSize = .medium
                config.cornerStyle = .medium
                config.title = "Invite Others..."
                return config
            }()
            return button
        }()
        view.addSubview(connectionButton)

        // MARK: streamCreateButton

        streamCreateButton = {
            let button = UIButton()
            button.addAction(
                UIAction { _ in
                    print("streamButton tapped")

                    // only stream to the first connected peer
                    guard let peer = self.mcSession.connectedPeers.first else {
                        print("connect to a peer first")
                        return
                    }
                    do {
                        // create the outputStream
                        try self.outputStream = self.mcSession.startStream(withName: "Stream", toPeer: peer) // this will call the `func session(_: MCSession, didReceive stream: InputStream, withName _: String, fromPeer _: MCPeerID)` to create the InputStream on the reciever.
                        self.outputStream.schedule(in: RunLoop.main, forMode: RunLoop.Mode.default)
                        self.outputStream.open()
                        print("open an outputStream")
                    } catch let error as NSError {
                        print("error in beginSession() = \(error)")
                    }
                }, for: .touchDown
            )
            button.configuration = {
                var config = UIButton.Configuration.tinted()
                config.buttonSize = .medium
                config.cornerStyle = .medium
                config.title = "Create the Stream"
                return config
            }()
            return button
        }()
        view.addSubview(streamCreateButton)

        // MARK: streamTestButton

        streamSendButton = {
            let button = UIButton()
            button.addAction(
                UIAction { _ in
                    print("streamButton tapped")
                    let string = "Testing stream"

                    // stream something
                    self.outputStream.write(string, maxLength: string.utf8.count)

                    print("outputStream.write \(string.utf8.count)")

                }, for: .touchDown
            )
            button.configuration = {
                var config = UIButton.Configuration.tinted()
                config.buttonSize = .medium
                config.cornerStyle = .medium
                config.title = "Test the Stream Using String"
                return config
            }()
            return button
        }()
        view.addSubview(streamSendButton)
    }

    override func viewWillLayoutSubviews() {
        chatView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chatView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            chatView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            chatView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            chatView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
        ])

        messageField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            messageField.topAnchor.constraint(equalToSystemSpacingBelow: chatView.bottomAnchor, multiplier: 1),
        ])

        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalToSystemSpacingAfter: messageField.trailingAnchor, multiplier: 1),
            sendButton.topAnchor.constraint(equalToSystemSpacingBelow: chatView.bottomAnchor, multiplier: 1),
        ])

        connectionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            connectionButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            connectionButton.topAnchor.constraint(equalToSystemSpacingBelow: messageField.bottomAnchor, multiplier: 1),
        ])

        streamCreateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            streamCreateButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            streamCreateButton.topAnchor.constraint(equalToSystemSpacingBelow: connectionButton.bottomAnchor, multiplier: 1),
        ])

        streamSendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            streamSendButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            streamSendButton.topAnchor.constraint(equalToSystemSpacingBelow: streamCreateButton.bottomAnchor, multiplier: 1),
        ])
    }

    override func viewDidLayoutSubviews() {}
}
