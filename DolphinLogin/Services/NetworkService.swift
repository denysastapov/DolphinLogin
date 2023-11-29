//
//  NetworkService.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import Foundation

class NetworkService {
    
    static let baseURL = URL(string: "https://dummyjson.com/")
    static let loginPath = "auth/login"
    static let addUserPath = "users/add"
    
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
    
    func sendRequest<T: Codable>(request: Request, completion: @escaping (T?) -> Void) {
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
                completion(nil)
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(decodedResponse)
                } catch {
                    print("Error decoding response data: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}
