//
//  LoginView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 18.11.2023.
//

//protocol LoginViewControllerDelegate: AnyObject {
//    func loginButtonPressed(username: String, password: String)
//    func registrationButtonPressed()
//}

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.makeHeaderLabel.text = "Login"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let usernameTextField = TextFieldCreation.makeTextField(placeholder: "Username")
    let passwordTextField = TextFieldCreation.makeTextField(placeholder: "Password", isSecureTextEntry: true)
    let loginButton = ControlsFactory.makeLoginButton()
    let registrationButton = ControlsFactory.makeRegisterButton()
    
    let dolphinImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dolphin"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoginViewUI()
        usernameTextField.text = "dpierrof"
        passwordTextField.text = "Vru55Y4tufI4"
        setupKeyboardHandling()
        
        view.backgroundColor = .white
        
        viewModel = LoginViewModel(networkService: NetworkService(), navigationController: self.navigationController!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        loginButton.addAction(UIAction(handler: { [ weak self]  _ in
            self?.loginButtonPressed()
        }), for: .touchUpInside)
        
        registrationButton.addAction(UIAction(handler: { [ weak self ] _ in
            self?.registrationButtonPressed()
        }), for: .touchUpInside)
    }
    
    private func setUpLoginViewUI() {
        
        let stackView = UIStackView(arrangedSubviews: [
            usernameTextField,
            passwordTextField
        ])
        
        self.view.addSubview(headerView)
        self.view.addSubview(dolphinImage)
        self.view.addSubview(stackView)
        self.view.addSubview(loginButton)
        self.view.addSubview(registrationButton)
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            dolphinImage.heightAnchor.constraint(equalToConstant: 120),
            dolphinImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dolphinImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -40),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            loginButton.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -20),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            registrationButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            registrationButton.widthAnchor.constraint(equalToConstant: 200),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func loginButtonPressed() {
            guard let username = usernameTextField.text, let password = passwordTextField.text else {
                return
            }
        self.viewModel.login(username: username, password: password)
    }
    
    internal func registrationButtonPressed() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 1.5) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
}
