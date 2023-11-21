//
//  ViewController.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import UIKit

class ViewController: UIViewController, NetworkMonitorDelegate, LoginViewControllerDelegate, RegistrationViewControllerDelegate {
    
    let loginApiUrl = URL(string: "https://dummyjson.com/auth/login")
    
    private lazy var networkService: NetworkServiceProtocol = {
        return NetworkService()
    }()
    
    private lazy var loginViewController: LoginViewController = {
        let viewController = LoginViewController()
        viewController.delegate = self
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.startMonitoring()
        
        loginViewController.delegate = self
        
        view.addSubview(loginViewController.view)
        
        NSLayoutConstraint.activate([
            loginViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            loginViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        addChild(loginViewController)
        loginViewController.didMove(toParent: self)
    }
    
    func loginButtonPressed(username: String, password: String) {
        guard let loginApiUrl = loginApiUrl else {
            print("Error: loginApiUrl is nil")
            return
        }
        let loginRequest = UserLoginRequest(username: username, password: password)
        
        networkService.sendRequest(url: loginApiUrl, 
                                   method: "POST",
                                   body: loginRequest,
                                   responseType: UserResponse.self
        ) { [weak self] user in
            guard let self = self else { return }
            
            if let user = user {
                DispatchQueue.main.async {
                    let userInfoViewController = UserInfoViewController(user: user)
                    self.navigationController?.pushViewController(userInfoViewController, animated: true)
                }
            } else {
                print("Error login")
            }
        }
    }
    
    func registrationButtonPressed() {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
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
