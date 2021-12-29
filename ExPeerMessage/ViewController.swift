// ViewController.swift

import UIKit

struct ExMessage: Codable, Hashable {
    let message: String
}

class ViewController: UIViewController {
    var textField: UITextField!
    var textView: UITextView!
    var button: UIButton!

    override func loadView() {
        print("loadView()")

        // MARK: view

        view = UIView()
        view.backgroundColor = .cyan

        // MARK: textView

        textView = UITextView()
        textView.text = "a\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\n"
        textView.textColor = .orange
        textView.textAlignment = .natural
        textView.isEditable = false
        textView.isSelectable = false
        textView.frame.size.width = 20
        view.addSubview(textView)

        // MARK: textField

        textField = UITextField()
        textField.placeholder = "Enter Message Here"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)

        // MARK: button

        button = UIButton()
        button.addAction(
          UIAction { _ in
            print("You tapped the button!")
          }, for: .touchDown
        )
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .medium
        config.cornerStyle = .medium
        config.title = "Send"
        button.configuration = config
        view.addSubview(button)
    }

    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews()")

        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            textView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            textView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            textView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
        ])

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            textField.topAnchor.constraint(equalToSystemSpacingBelow: textView.bottomAnchor, multiplier: 1),
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            button.topAnchor.constraint(equalToSystemSpacingBelow: textView.bottomAnchor, multiplier: 1),
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
