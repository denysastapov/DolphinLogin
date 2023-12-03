//
//  AllUsersModel.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 01.12.2023.
//
import Foundation

final class AllUsersModel {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getAllUsers(completion: @escaping (Result<(Data, URLResponse),Error>) -> Void) {
        
        let allUsersRequest = NetworkService.Request(
            baseURL: NetworkConstants.baseURL!,
            path: NetworkConstants.allUsersPath,
            method: .GET,
            body: nil,
            headers: [:]
        )
        
        networkService.sendRequest(request: allUsersRequest) { result in
            switch result {
            case .success(let response):
                completion(.success((response.data, response.urlResponse)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct HTTPSDummyjsonCOMUsers: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable{
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender: String
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height: Int
    let weight: Double
    let eyeColor: EyeColor
    let hair: Hair
    let domain, ip: String
    let address: Address
    let macAddress, university: String
    let bank: Bank
    let company: Company
//    let ein, ssn, userAgent: String
}

struct Address: Codable {
    let address: String
    let city: String?
    let coordinates: Coordinates
    let postalCode, state: String
}

struct Coordinates: Codable {
    let lat, lng: Double
}

struct Bank: Codable {
    let cardExpire, cardNumber, cardType, currency: String
    let iban: String
}

struct Company: Codable {
    let address: Address
    let department, name, title: String
}

enum EyeColor: String, Codable {
    case amber = "Amber"
    case blue = "Blue"
    case brown = "Brown"
    case gray = "Gray"
    case green = "Green"
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

struct Hair: Codable {
    let color: Color
    let type: TypeEnum
}

enum Color: String, Codable {
    case auburn = "Auburn"
    case black = "Black"
    case blond = "Blond"
    case brown = "Brown"
    case chestnut = "Chestnut"
}

enum TypeEnum: String, Codable {
    case curly = "Curly"
    case straight = "Straight"
    case strands = "Strands"
    case veryCurly = "Very curly"
    case wavy = "Wavy"
}
