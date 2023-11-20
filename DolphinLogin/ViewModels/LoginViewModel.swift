//
//  LoginViewModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    var apiUrl: URL { get }
    func loginUser(username: String, password: String, completion: @escaping (UserResponseProtocol?) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    var apiUrl: URL
    
    init(apiUrl: URL) {
        self.apiUrl = apiUrl
    }
    
    func loginUser(username: String, password: String, completion: @escaping (UserResponseProtocol?) -> Void) {
        var urlRequest = URLRequest(url: apiUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginRequest = UserLoginRequest(username: username, password: password)
        
        do {
            let jsonData = try JSONEncoder().encode(loginRequest)
            urlRequest.httpBody = jsonData
        } catch {
            print("Error encoding login request: \(error)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                let loginUser = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(loginUser)
            } catch let decodingError {
                print("Error decoding login user data: \(decodingError)")
                completion(nil)
            }
        }.resume()
    }
}
