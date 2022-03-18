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

//class ViewController: UIViewController {
//
//    let counterButton = CustomButton(title:"Button1")
//    let closureButton = CustomButton(title:"Button2")
//    var counterButtonAction: ((inout Int) -> ())?
//    var closureButtonAction: () -> (String)
//    let textField = UITextField()
//
//    private(set) var buttonPressCount = 0
//
//    init(button2Action: @escaping () -> (String) = {""}) {
//        self.closureButtonAction = button2Action
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        view.keyboardLayoutGuide.followsUndockedKeyboard = true
//        configureView()
//    }
//
//    private func configureView() {
//
//        [textField].forEach {
//            view.addSubview($0)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//        textField.borderStyle = .roundedRect
//
//        NSLayoutConstraint.activate([
//            textField.widthAnchor.constraint(equalToConstant: 200),
//            textField.heightAnchor.constraint(equalToConstant: 20),
//            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//
//        let textFieldOnKeyboard = view.keyboardLayoutGuide.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 100)
//        textFieldOnKeyboard.identifier = "textFieldOnKeyboard"
//        view.keyboardLayoutGuide.setConstraints([textFieldOnKeyboard], activeWhenAwayFrom: .top)
//    }
//
//    @objc
//    internal func button1Tap() {
//        counterButtonAction?(&buttonPressCount)
//    }
//
//    @objc
//    internal func button2Tap() {
//        print(closureButtonAction())
//    }
//}

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


//
//struct LoginViewModel {
//    
//    private let userSubject = PassthroughSubject<User,Never>()
//    
//    var userPublisher: AnyPublisher<User,Never> {
//        userSubject.eraseToAnyPublisher()
//    }
//    
//    func fetchUser() {
//        
//        print("The SEND thread: \(Thread.current)")
//        userSubject.send(User(name: "Mike", age: 32))
//    }
//}
