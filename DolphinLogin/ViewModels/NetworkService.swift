//
//  NetworkService.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func sendRequest<T: Codable>(url: URL, 
                                 method: String,
                                 body: Encodable?,
                                 responseType: T.Type,
                                 completion: @escaping (T?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func sendRequest<T: Codable>(url: URL, 
                                 method: String,
                                 body: Encodable?,
                                 responseType: T.Type,
                                 completion: @escaping (T?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body, method == "POST" {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                print("Error encoding request body: \(error)")
                completion(nil)
                return
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(decodedResponse)
            } catch let decodingError {
                print("Error decoding response data: \(decodingError)")
                completion(nil)
            }
        }.resume()
    }
}
