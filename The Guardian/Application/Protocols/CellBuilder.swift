//
//  CellBuilder.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 31/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

protocol CellBuilder {
    associatedtype Data
    var identifier: String { get set }
    func configureCell(_ cell: inout UICollectionViewCell, data: Data)
    func didSelectCell(at indexPath: IndexPath, data: Data?)
}
