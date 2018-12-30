//
//  ArticleCellBuilder.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

class ArticleCellBuilder: CellBuilder {
    func configureCell(_ cell: inout UITableViewCell, data: ObjectArticle) {
        guard let cell = cell as? ArticleTableViewCell else { return }
        cell.sectionNameLabel.text = data.sectionName ?? ""
        cell.titleLabel.text = data.webTitle ?? ""
        cell.firstLineText.text = data.fields?.bodyText ?? ""
//        cell.thumbnailImageView.text = data.fields?.bodyText ?? ""
    }
}
