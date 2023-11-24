//
//  LoginViewModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 22.11.2023.
//
import UIKit

class LoginViewModel {
    
    init(networkService: NetworkService, navigationController: UINavigationController) {
        self.networkService = networkService
        self.navigationController = navigationController
    }
    
    private let networkService: NetworkService
    var navigationController: UINavigationController?
    
    func login(username: String, password: String) {

        let loginRequest = UserLoginRequest(username: username, password: password)
        
        let networkService = NetworkService()
        
        networkService.sendRequest(url: NetworkService.loginApiUrl,
                                   method: "POST",
                                   body: loginRequest
        ) { [weak self] (user: UserRegistrationModel?) in
            if let user = user {
                DispatchQueue.main.async {
                    let userInfoViewController = UserInfoViewController(user: user)
                    self?.navigationController?.pushViewController(userInfoViewController, animated: true)
                }
            } else {
                print("Error login")
            }
        }
    }
}
