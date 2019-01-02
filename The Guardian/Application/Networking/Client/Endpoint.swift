//
//  Endpoint.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var urlParameters: [URLQueryItem] { get }
    var bodyParameters: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
}

extension Endpoint {
    
    var urlParameters: [URLQueryItem] {
        return []
    }
    
    var bodyParameters: [URLQueryItem] {
        return []
    }
    
    var urlComponents: URLComponents? {
        var urlComponent = URLComponents(string: baseUrl)
        if !path.isEmpty {
            urlComponent?.path = path
        }
        urlComponent?.queryItems = urlParameters
        return urlComponent
    }
    
    var httpBody: Data? {
        var component = URLComponents()
        component.queryItems = bodyParameters
        return component.query?.data(using: .utf8)
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        
        return request
    }
}
