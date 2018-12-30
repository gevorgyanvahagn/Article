//
//  Either.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

enum Either<T> {
    case success(T)
    case error(Error)
}
