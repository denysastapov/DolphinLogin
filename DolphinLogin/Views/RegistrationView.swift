//
//  RegistrationView.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

protocol RegistrationViewControllerDelegate: AnyObject {
    func registrationButtonPressed()
}

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: RegistrationViewControllerDelegate?
    
    let addUserApiUrl = URL(string: "https://dummyjson.com/users/add")
    
    private lazy var networkService: NetworkServiceProtocol = {
        return NetworkService()
    }()
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.labelText = "Registration"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstNameTextField = TextFieldCreation.makeTextField(placeholder: "First Name")
    let lastNameTextField = TextFieldCreation.makeTextField(placeholder: "Last Name")
    let emailTextField = TextFieldCreation.makeTextField(placeholder: "Email", keyboardType: .emailAddress)
    let passwordTextField = TextFieldCreation.makeTextField(placeholder: "Password", isSecureTextEntry: true)
    let ageTextField = TextFieldCreation.makeTextField(placeholder: "Age", keyboardType: .numberPad)
    let genderLabel = ControlsFactory.makeLabel(forText: "Gender")
    let genderSegmentedControl = ControlsFactory.makeSegmentedControl()
    let registerButton = ControlsFactory.makeRegisterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardHandling()
        
        registerButton.addAction(UIAction(handler: { [weak self] _ in
            self?.registerButtonPressed()
        }), for: .touchUpInside)
        
        navigationController?.navigationBar.tintColor = .white
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        let stackView = UIStackView(arrangedSubviews: [
            firstNameTextField,
            lastNameTextField,
            emailTextField,
            passwordTextField,
            genderLabel,
            genderSegmentedControl,
            ageTextField
        ])
        view.addSubview(headerView)
        view.addSubview(stackView)
        view.addSubview(registerButton)
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func registerButtonPressed() {
        guard let addUserApiUrl = addUserApiUrl else {
            print("Invalid addUserApiUrl")
            return
        }

        let genderOptions = ["Male", "Female"]
        let selectedGender = genderOptions[genderSegmentedControl.selectedSegmentIndex]
        
        let registrationRequest: UserResponseProtocol = UserResponse(
            id: nil,
            username: nil,
            email: emailTextField.text ?? "",
            firstName: firstNameTextField.text ?? "",
            lastName: lastNameTextField.text ?? "",
            gender: selectedGender,
            image: nil,
            token: nil,
            age: ageTextField.text ?? ""
        )

        networkService.sendRequest(url: addUserApiUrl, method: "POST", body: registrationRequest, responseType: UserResponse.self) { [weak self] (user: UserResponse?) in
            guard let self = self else { return }

            if let user = user {
                DispatchQueue.main.async {
                    let userInfoViewController = UserInfoViewController(user: user)
                    self.navigationController?.pushViewController(userInfoViewController, animated: true)
                }
            } else {
                print("Error sending request or decoding response")
            }
        }
    }
}
