//
//  RegistrationViewModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 23.11.2023.
//

import UIKit

class RegistrationViewModel {
    
    var navigationController: UINavigationController?
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private var userGender = ""
    private var userEmail = ""
    private var userFirstName = ""
    private var userLastName = ""
    private var userPassword = ""
    private var userAge = ""
    
    var isUserEmailValid: ((Bool) -> ())!
    var isUserFirstNameValid: ((Bool) -> ())!
    var isUserLastNameValid: ((Bool) -> ())!
    var isUserPasswordValid: ((Bool) -> ())!
    var isUserAgeValid: ((Bool) -> ())!
    
    func setUpUserGender(userGender: String) {
        self.userGender = userGender
    }
    
    func setUpUserEmail(userEmail: String) {
        self.userEmail = userEmail
        ValidationFieldsHelper.isValidEmail(userEmail) ? isUserEmailValid(true) : isUserEmailValid(false)
    }
    
    func setUpUserFirstName(userFirstName: String) {
        self.userFirstName = userFirstName
        ValidationFieldsHelper.isValidName(userFirstName) ? isUserFirstNameValid(true) : isUserFirstNameValid(false)
    }
    
    func setUpUserLastName(userLastName: String) {
        self.userLastName = userLastName
        ValidationFieldsHelper.isValidName(userLastName) ? isUserLastNameValid(true) : isUserLastNameValid(false)
    }
    
    func setUpUserPassword(userPassword: String) {
        self.userPassword = userPassword
        ValidationFieldsHelper.isValidPassword(userPassword) ? isUserPasswordValid(true) : isUserPasswordValid(false)
    }
    
    func setUpUserAge(userAge: String) {
        self.userAge = userAge
        ValidationFieldsHelper.isValidAge(userAge) ? isUserAgeValid(true) : isUserAgeValid(false)
    }
    
    func isValidRegistration() -> Bool {
        return ValidationFieldsHelper.isValidName(userFirstName) &&
        ValidationFieldsHelper.isValidName(userLastName) &&
        ValidationFieldsHelper.isValidEmail(userEmail) &&
        ValidationFieldsHelper.isValidPassword(userPassword) &&
        ValidationFieldsHelper.isValidAge(userAge)
    }
    
    func register() {
            
        let registrationData = UserRegistrationModel(
            id: nil,
            username: nil,
            email: userEmail,
            firstName: userFirstName,
            lastName: userLastName,
            gender: userGender,
            image: nil,
            token: nil,
            age: userAge
        )
        
        let registrationRequest = NetworkService.Request(
            baseURL: NetworkConstants.baseURL!,
            path: NetworkConstants.addUserPath,
            method: .POST,
            body: registrationData.asData,
            headers: ["Content-Type": "application/json" as AnyObject]
        )
        
        networkService.sendRequest(request: registrationRequest) { [ weak self ] (result) in
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
                                age: user.age!
                            )
                        )
                        self?.navigationController?.pushViewController(userInfoViewController, animated: true)
                    }
                }
                catch {
                    print("Error registration")
                }
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
}
