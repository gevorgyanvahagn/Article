//
//  CellBuilder.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

protocol CellBuilder {
    associatedtype Data
    func configureCell(_ cell: inout UITableViewCell, data: Data)
}
