// ViewController.swift

import UIKit

struct ExMessage: Codable, Hashable {
    let message: String
}

let width = 200.0
let height = 300.0
let x = UIScreen.main.bounds.size.width / 2 - width / 2
let y = UIScreen.main.bounds.size.height / 2 - height / 2

class ViewController: UIViewController {
    var testLabel: UILabel!
    var textView: UITextView!

    // https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457
    override func loadView() {
        // MARK: view

        // var view = UIView!
        // This property represents the root view of the view controller's view hierarchy. The default value of this property is nil.
        // If you access this property when its value is nil, the view controller automatically calls the loadView() method and returns the resulting view.
        view = UIView()
        view.backgroundColor = .cyan

        // MARK: textView

        textView = UITextView(frame:
            .init(x: x,
                  y: y,
                  width: width,
                  height: height))
        textView.text = "aaaaaaaaa"
        textView.textColor = .orange
        textView.textAlignment = .center

        textView.isEditable = false
        textView.isSelectable = false

        view.addSubview(textView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print("ViewController.viewDidLoad()")
    }
}
