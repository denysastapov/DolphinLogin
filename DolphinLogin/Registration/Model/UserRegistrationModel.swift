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
    var email: String? { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var gender: String? { get }
    var image: String? { get }
    var token: String? { get }
    var age: String? { get }

    var asData: Data? { get }
}

extension Encodable {
    var asData: Data? {
        try? JSONEncoder().encode(self)
    }
}

struct UserRegistrationModel: UserRegistrationModelProtocol {
    var id: Int?
    var username: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var image: String?
    var token: String?
    var age: String?
}
