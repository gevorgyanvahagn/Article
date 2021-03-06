//
//  ArticleDetailsViewController.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class ArticleDetailsViewController: UIViewController {
    
    private var tagsCollectionViewHandler: CollectionViewHandler<String, TagCellBuilder>?
    private var wordsCollectionViewHandler: CollectionViewHandler<String, TagCellBuilder>?
    
    @IBOutlet weak var tagsCollectionView: TagsCollectionView!
    @IBOutlet weak var wordsCollectionView: TagsCollectionView!
    
    @IBOutlet weak var bottomSectionNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var readingDurationLabel: UILabel!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var bottomDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var highlitedWord: String?
    var article: ObjectArticle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticle()
        configureSearchCollection()
    }
    
    private func addConfiguredLayout() ->UICollectionViewLeftAlignedLayout {
        let layout = UICollectionViewLeftAlignedLayout()
        layout.estimatedItemSize = CGSize(width: 30, height: 25)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 2
        return layout
    }
    
    private func configureSearchCollection() {
        guard let article = article else {
            assertionFailure()
            return
        }
        
        tagsCollectionView.collectionViewLayout = addConfiguredLayout()
        tagsCollectionView.allowsSelection = false
        
        wordsCollectionView.collectionViewLayout = addConfiguredLayout()
        wordsCollectionView.allowsSelection = true
        
        tagsCollectionViewHandler = CollectionViewHandler(collectionView: tagsCollectionView, cellBuilder: TagCellBuilder())
        tagsCollectionViewHandler?.dataSource = article.tags
        
        let wordsCellBuilder = TagCellBuilder()
        wordsCellBuilder.didSelectCellAction = { [weak self] (index, word) in
            guard let word = word else {
                assertionFailure()
                return
            }
            
            if word == self?.highlitedWord {
                self?.highlight(word: nil)
                self?.wordsCollectionViewHandler?.deselect(at: index)
            } else {
                self?.highlight(word: word)
            }
        }
        wordsCollectionViewHandler = CollectionViewHandler(collectionView: wordsCollectionView, cellBuilder: wordsCellBuilder)
        print("1", Date())
        
        DispatchQueue.global(qos: .background).async {
            let words = article.frequentWords
            DispatchQueue.main.async {
                self.wordsCollectionViewHandler?.dataSource = words
            }
        }
        
    }
    
    private func loadArticle() {
        guard let article = article else {
            assertionFailure("Article is missing")
            return
        }
        
        sectionNameLabel.text = article.sectionName ?? ""
        bottomSectionNameLabel.text = article.sectionName ?? ""
        
        navigationItem.title = article.sectionName ?? ""
        titleLabel.text = article.webTitle ?? ""
        
        if let imageURL = article.fields?.thumbnail {
            thumbnailImageView.setImage(with: imageURL)
            bottomImageView.setImage(with: imageURL)
        }
        
        articleTextLabel.text = article.fields?.bodyText ?? ""
        if let date = article.createdDate {
            bottomDateLabel.text = DateFormatter.shortFormatter.string(from: date)
            dateLabel.text = DateFormatter.shortFormatter.string(from: date)
        } else {
            bottomDateLabel.text = ""
            dateLabel.text = ""
        }
        
        let readingTime = article.fields?.bodyText?.readingDuration ?? 0
        readingDurationLabel.text = "\(readingTime) min read"
    }
    
    private func highlight(word: String?) {
        guard let articleText = article?.fields?.bodyText else {
            assertionFailure()
            return
        }
        highlitedWord = word
        articleTextLabel.attributedString(in: articleText, changedString: word, atributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .heavy)])
    }
}
