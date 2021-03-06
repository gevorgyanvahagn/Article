//
//  ArticleCellBuilder.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class ArticleCellBuilder: RowBuilder {
    
    typealias SelectAction = (IndexPath, ObjectArticle?) -> ()
    var didSelectCellAction: SelectAction?
    
    func didSelectCell(at indexPath: IndexPath, data: ObjectArticle?) {
        didSelectCellAction?(indexPath, data)
    }
    
    func configureCell(_ cell: inout UITableViewCell, data: ObjectArticle) {
        guard let cell = cell as? ArticleTableViewCell else { return }
        cell.sectionNameLabel.text = data.sectionName ?? ""
        cell.titleLabel.text = data.webTitle ?? ""
        cell.firstLineText.text = data.fields?.bodyText ?? ""
        if let imageURL = data.fields?.thumbnail {
            cell.thumbnailImageView.setImage(with: imageURL)
        } else {
            cell.thumbnailImageView.image = #imageLiteral(resourceName: "Placeholder")
        }
        
        if let date = data.createdDate {
            cell.dateLabel.text = DateFormatter.shortFormatter.string(from: date)
        } else {
            cell.dateLabel.text = ""
        }
        let readingTime = data.fields?.bodyText?.readingDuration ?? 0
        cell.readingDurationLabel.text = "\(readingTime) min read"
    }
}
