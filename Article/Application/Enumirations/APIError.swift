//
//  APIError.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknown
    case badResponse
    case badRequest
    case jsonDecoder
    case imageDownload
}
