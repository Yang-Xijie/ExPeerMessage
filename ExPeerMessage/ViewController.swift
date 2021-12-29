// ViewController.swift

import UIKit

struct ExMessage: Codable, Hashable {
    let message: String
}

class ViewController: UIViewController {
    var textField: UITextField!
    var textView: UITextView!

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
