//
//  APIClient.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    func request<T: Decodable >(with request: URLRequest?, completion: @escaping (Either<T>) -> Void)
}

extension APIClient {
    
    var session: URLSession {
        return URLSession.shared
    }
    
    func request<T: Decodable>(with request: URLRequest?, completion: @escaping (Either<T>) -> Void) {
        
        guard let request = request else {
            completion(.error(APIError.badRequest))
            return
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            
            // TODO: - for test only, remove before sending
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                
                DispatchQueue.main.async {
                    completion(.error(APIError.badResponse))
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(value))
                }
            } catch let error {
                completion(.error(error))
            }
        }
        task.resume()
    }
}
