// ViewController.swift

import MultipeerConnectivity
import UIKit

class ViewController: UIViewController {
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
            textView.text = "a\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\n"
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
            return button
        }()
        view.addSubview(sendButton)

        // MARK: connectionButton

        connectionButton = {
            let button = UIButton()
            button.addAction(
                UIAction { _ in
                    print("connectionButton tapped")
                    let hostChatAlertAction: UIAlertAction = {
                        let alertAction = UIAlertAction(title: "Host Chat", style: .default) { _ in
                            self.hosting = true
                        }
                        // to invite others to join the room
                        self.mcBrowser = MCBrowserViewController(serviceType: "ExPeerMessage", session: self.mcSession)
                        self.mcBrowser.delegate = self
                        self.present(self.mcBrowser, animated: true, completion: { print("presented") })

                        return alertAction
                    }()

                    let joinChatAlertAction: UIAlertAction = {
                        let alertAction = UIAlertAction(title: "Join Chat", style: .default) { _ in
                            self.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "ExPeerMessage", discoveryInfo: nil, session: self.mcSession)
                            self.mcAdvertiserAssistant.start()
                        }
                        return alertAction
                    }()

                    let connectActionSheet = UIAlertController(title: "Our chat", message: "Do you want to host or join a chat?", preferredStyle: .actionSheet)
                    connectActionSheet.addAction(hostChatAlertAction)
                    connectActionSheet.addAction(joinChatAlertAction)
                    connectActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                    // works on iPad
                    connectActionSheet.popoverPresentationController?.sourceView = button
                    self.present(connectActionSheet, animated: true, completion: nil)

//
                    ////
//                    if !self.hosting {
//                        // I want to host the room
//

//                    }
//                    else {
//                        // self.hosting == true
//                        let disconnectAlertAction: UIAlertAction = {
//                            let alertAction = UIAlertAction(title: "Disconnect", style: .destructive) { _ in
//                                self.mcSession.disconnect()
//                                self.hosting = false
//                            }
//                            return alertAction
//                        }()
//
//                        let waitActionSheet = UIAlertController(title: "Waiting...", message: "Waiting for others to join the chat...", preferredStyle: .actionSheet)
//                        waitActionSheet.addAction(disconnectAlertAction)
//                        waitActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//                        waitActionSheet.popoverPresentationController?.sourceView = button
//                        self.present(waitActionSheet, animated: true, completion: nil)
//                    }
                }, for: .touchDown
            )
            button.configuration = {
                var config = UIButton.Configuration.tinted()
                config.buttonSize = .medium
                config.cornerStyle = .medium
                config.title = "Connection"
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

    // MARK: - properties

    var reMsg: String!
    var sendMsg: String!
    var hosting: Bool!

    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!

    var mcBrowser: MCBrowserViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad()")

        self.setupHideKeyboardOnTap()

        sendButton.isEnabled = false

        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self

        hosting = false

        self.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "ExPeerMessage", discoveryInfo: nil, session: self.mcSession)
        self.mcAdvertiserAssistant.start()
    }

    @objc func removeKeyboard(_: UIGestureRecognizer) {
        self.messageField.endEditing(true)
    }
}

extension UIViewController {
    // Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
