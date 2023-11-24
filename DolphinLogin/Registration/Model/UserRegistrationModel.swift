//
// UserRegistrationModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import Foundation

protocol UserRegistrationModelProtocol: Codable {
    var id: Int? { get }
    var username: String? { get }
    var email: String { get }
    var firstName: String { get }
    var lastName: String { get }
    var gender: String { get }
    var image: String? { get }
    var token: String? { get }
    var age: String? { get }
}

struct UserRegistrationModel: UserRegistrationModelProtocol {
    let id: Int?
    let username: String?
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String?
    let token: String?
    let age: String?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case firstName
        case lastName
        case gender
        case image
        case token
        case age
    }
}
