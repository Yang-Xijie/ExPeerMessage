// ViewController.swift

import UIKit

struct ExMessage: Codable, Hashable {
    let message: String
}

class ViewController: UIViewController {
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
                    print("You tapped the button!")
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
        print("viewWillLayoutSubviews()")

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
        print("viewDidLayoutSubviews()")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad()")
    }
}

// extension ViewController {
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
// }
