//
//  RegistrationViewModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 23.11.2023.
//

import UIKit

class RegistrationViewModel {
    
    var navigationController: UINavigationController?
    var registrationViewController = RegistrationViewController()
    private let networkService: NetworkService
    
    init(networkService: NetworkService, registrationViewContriller: RegistrationViewController, navigationController: UINavigationController?) {
        self.networkService = networkService
        self.registrationViewController = registrationViewContriller
        self.navigationController = navigationController
    }
    
    func register() {
        
        let genderOptions = ["Male", "Female"]
        let selectedGender = genderOptions[registrationViewController.genderSegmentedControl.selectedSegmentIndex]
        
        let registarionRequest = UserRegistrationModel(
            id: nil,
            username: nil,
            email: registrationViewController.emailTextField.text ?? "",
            firstName: registrationViewController.firstNameTextField.text ?? "",
            lastName: registrationViewController.lastNameTextField.text ?? "",
            gender: selectedGender,
            image: nil,
            token: nil,
            age: registrationViewController.ageTextField.text ?? ""
        )
        networkService.sendRequest(url: NetworkService.addUserApiUrl,
                                   method: "POST",
                                   body: registarionRequest
        ) { [ weak self ] (user: UserRegistrationModel?)  in
            
            if let user = user {
                DispatchQueue.main.async { [ weak self ] in
                    let userInfoViewController = UserInfoViewController(user: user)
                    self?.navigationController?.pushViewController(userInfoViewController, animated: true)
                }
            }
        }
    }
}
