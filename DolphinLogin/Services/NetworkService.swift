//
//  NetworkService.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import Foundation

enum NetworkConstants {
    static let baseURL = URL(string: "https://dummyjson.com/")
    static let loginPath = "auth/login"
    static let addUserPath = "users/add"
    static let allUsersPath = "users"
}

class NetworkService {
    
    struct UnknownError: Error {}
    
    struct Request {
        let baseURL: URL
        let path: String
        let method: Method
        let body: Data?
        let headers: [String: AnyObject]
        
        enum Method: String {
            case GET
            case POST
        }
    }
    
    struct Response {
        let urlResponse: URLResponse
        let data: Data
    }
    
    func sendRequest(request: Request, completion: @escaping (Result<Response, Error>) -> Void) {
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path))
        
        urlRequest.httpMethod = request.method.rawValue
        
        for (key, value) in request.headers {
            urlRequest.addValue("\(value)", forHTTPHeaderField: key)
        }

        if let body = request.body {
            urlRequest.httpBody = body
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }

            if let data = data, let response = response {
                completion(.success(Response.init(urlResponse: response, data: data)))
            } else {
                completion(.failure(UnknownError()))
            }
        }.resume()
    }
}
