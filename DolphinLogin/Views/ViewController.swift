//
//  ViewController.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import UIKit

class ViewController: UIViewController, NetworkMonitorDelegate, LoginViewDelegate {
    
    let apiUrl = URL(string: "https://dummyjson.com/auth/login")
//    guard let apiUrl = URL(string: "https://dummyjson.com/users/add") else { return }
    private lazy var loginViewModel: LoginViewModelProtocol = {
        return LoginViewModel(apiUrl: apiUrl!)
    }()
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.startMonitoring()
        
        loginView.delegate = self
        
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        //        view.addSubview(registrationView)
        //
        //        NSLayoutConstraint.activate([
        //            registrationView.topAnchor.constraint(equalTo: view.topAnchor),
        //            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //            registrationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        //        ])
        
        //        let addUserRequest = AddUserRequest(
        //            email: "muh@muh.com",
        //            password: "0123456789",
        //            firstName: "Muhammad",
        //            lastName: "Ovi",
        //            gender: "Male",
        //            age: 250
        //        )
        //
        //        loginViewModel.addUser(request: addUserRequest) { addedUser in
        //            if let addedUser = addedUser {
        //                print("User added successfully:")
        //                print("ID: \(addedUser.id)")
        //                print("Password: \(addedUser.password)")
        //                print("Email: \(addedUser.email)")
        //                print("FirstName: \(addedUser.firstName)")
        //                print("LastName: \(addedUser.lastName)")
        //                print("Gender: \(addedUser.gender)")
        //                print("Age: \(addedUser.age)")
        //            } else {
        //                print("Failed to add user.")
        //            }
        //        }
    }
    func loginButtonPressed(username: String, password: String) {
        loginViewModel.loginUser(username: username, password: password) { [weak self] user in
            guard let self = self else { return }
            if let user = user {
                DispatchQueue.main.async {
                    let userInfoView = UserInfoView(user: user)
                    
                    self.loginView.removeFromSuperview()
                    
                    self.view.addSubview(userInfoView)
                    userInfoView.frame = self.view.bounds
                }
            } else {
            }
        }
    }
    
    
    func networkStatusDidChange(_ isConnected: Bool) {
        if !isConnected {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No internet connection",
                                              message: "Please check your network connection.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
