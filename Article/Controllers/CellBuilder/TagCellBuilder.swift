//
//  TagCellBuilder.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 31/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class TagCellBuilder: CellBuilder {
    var identifier = TagCollectionViewCell.className
    typealias SelectAction = (IndexPath, String?) -> ()
    var didSelectCellAction: SelectAction?
    
    func didSelectCell(at indexPath: IndexPath, data: String?) {
        didSelectCellAction?(indexPath, data)
    }
    
    func configureCell(_ cell: inout UICollectionViewCell, data: String) {
        guard let cell = cell as? TagCollectionViewCell else { return }
        cell.titleLabel.text = data
    }
}
