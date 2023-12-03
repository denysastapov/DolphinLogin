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
            baseURL: NetworkConstants.baseURL!,
            path: NetworkConstants.loginPath,
            method: .POST,
            body: loginData.asData,
            headers: ["Content-Type": "application/json" as AnyObject]
        )
        
        networkService.sendRequest(request: loginRequest) { [ weak self ] (result) in
            switch result {
            case .success(let response):
                do {
                    let user = try JSONDecoder().decode(UserRegistrationModel.self, from: response.data)
                    DispatchQueue.main.async { [ weak self ] in
                        let userInfoViewController = UserInfoViewController(
                            user: UserInfoViewController.UserInfo(
                                firstName: user.firstName!,
                                lastName: user.lastName!,
                                image: user.image!,
                                email: user.email!,
                                gender: user.gender!,
                                age: user.age ?? ""
                            )
                        )
                        self?.navigationController?.pushViewController(userInfoViewController, animated: true)
                    }
                }
                catch {
                    print("Error logging in")
                }
            case .failure(let error):
                print("Error \(error))")
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
