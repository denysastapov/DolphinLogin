//
//  UserLoginModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 23.11.2023.
//

import Foundation

struct UserLoginRequest: Codable {
    let username: String
    let password: String
}
