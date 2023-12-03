//
//  AllUsersViewModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 01.12.2023.
//

import UIKit

class AllUsersViewModel {
    
    var navigationCoolController: UINavigationController?
    private let model: AllUsersModel
    
    init(model: AllUsersModel) {
        self.model = model
    }
    
    var users: [User] = []
    
    func fetchAllUsers() {

        model.getAllUsers(completion: { [weak self] (result) in
            switch result {
            case .success((let data, _)):
                
                do {
                    let users = try JSONDecoder().decode(HTTPSDummyjsonCOMUsers.self, from: data)
                    
                    DispatchQueue.main.async {
                        if !users.users.isEmpty {
                            self?.users = users.users
                        }
                        
                        let allUsersTableViewController = AllUsersTableViewController(users: self?.users ?? [])
                        self?.navigationCoolController?.pushViewController(allUsersTableViewController, animated: true)
                    }
                    
                } catch let decodingError {
                    print("Error decoding data: \(decodingError)")
                }
                
            case .failure(let error):
                print("Error \(error)")
            }
        })
    }
}
