import UIKit
class ViewController: UIViewController {

    let counterButton = CustomButton(title:"Button1")
    let closureButton = CustomButton(title:"Button2")
    var counterButtonAction: ((inout Int) -> ())?
    var closureButtonAction: () -> (String)

    private(set) var buttonPressCount = 0

    init(button2Action: @escaping () -> (String) = {""}) {
        self.closureButtonAction = button2Action
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureView()
    }

    private func configureView() {

        [counterButton, closureButton].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            counterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            closureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closureButton.topAnchor.constraint(equalTo: counterButton.bottomAnchor, constant: 10)
        ])

        counterButton.addTarget(self, action: #selector(button1Tap), for: .touchUpInside)
        closureButton.addTarget(self, action: #selector(button2Tap), for: .touchUpInside)

        counterButtonAction = { count in
            count += 1
            print(count)
        }
    }

    @objc
    internal func button1Tap() {
        counterButtonAction?(&buttonPressCount)
    }

    @objc
    internal func button2Tap() {
        print(closureButtonAction())
    }
}

final class CustomButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureAppareance(with: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureAppareance(with title: String) {
        backgroundColor = .black
        setTitle(title, for: .normal)
    }
}
