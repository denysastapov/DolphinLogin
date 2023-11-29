//
//  LoginViewModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 22.11.2023.
//
import UIKit

class LoginViewModel {
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private let networkService: NetworkService
    var navigationController: UINavigationController?
    
    func login(username: String, password: String) {
        
        let loginData = UserLoginRequest(username: username, password: password)
        
        let loginRequest = NetworkService.Request(
            baseURL: NetworkService.baseURL!,
            path: NetworkService.loginPath,
            method: .POST,
            body: try? JSONEncoder().encode(loginData),
            headers: ["Content-Type": "application/json" as AnyObject]
        )
        
        networkService.sendRequest(request: loginRequest) { [ weak self ] (user: UserRegistrationModel?) in
            if let user = user {
                DispatchQueue.main.async { [ weak self ] in
                    let userInfoViewController = UserInfoViewController(user: user)
                    self?.navigationController?.pushViewController(userInfoViewController, animated: true)
                }
            } else {
                print("Error logging in")
            }
        }
    }
    
    func prepareRegisrationViewController() {
        let registrationViewController = RegistrationViewController()
        let viewModel = RegistrationViewModel(networkService: networkService)
        registrationViewController.viewModel = viewModel
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
}
