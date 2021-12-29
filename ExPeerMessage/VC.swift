import MultipeerConnectivity
import UIKit

class ViewController: UIViewController {
    // MARK: - properties

    var mcSession: MCSession!
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    var mcBrowserViewController: MCBrowserViewController!

    // MARK: - subviews

    var chatView: UITextView!
    var messageField: UITextField!
    var sendButton: UIButton!
    var connectionButton: UIButton!

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
            textView.text = "Hello, world.\nHi~"
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
                    self.mcBrowserViewController = MCBrowserViewController(serviceType: "ExPeerMessage", session: self.mcSession)
                    self.mcBrowserViewController.delegate = self
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
    }

    override func viewWillLayoutSubviews() {
//        print("viewWillLayoutSubviews()")

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
    }

    override func viewDidLayoutSubviews() {
//        print("viewDidLayoutSubviews()")
    }

    // MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad()")

        self.setupHideKeyboardOnTap()

        mcSession = MCSession(peer: myID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self

        self.mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: myID, discoveryInfo: nil, serviceType: "ExPeerMessage")
        mcNearbyServiceAdvertiser.delegate = self
        mcNearbyServiceAdvertiser.startAdvertisingPeer()
    }
}
