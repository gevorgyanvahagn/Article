//
//  TagCollectionViewCell.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 31/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                super.isSelected = isSelected
                containerView.backgroundColor = UIColor(red:0.02, green:0.06, blue:0.06, alpha:1.0)
            } else {
                super.isSelected = isSelected
                containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
            }
        }
    }
    
    override func awakeFromNib() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
