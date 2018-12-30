//
//  ArticleCellBuilder.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class ArticleCellBuilder: CellBuilder {
    
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
        let readingTime = calculateReadingTime(article: data)
        cell.readingDurationLabel.text = "\(readingTime) min read"
    }
    
    private func calculateReadingTime(article: ObjectArticle) -> Int {
        guard let articleText = article.fields?.bodyText else {
            return 0
        }
        
        return Int(articleText.count / 500)
    }
}
