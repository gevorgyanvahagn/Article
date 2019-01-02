//
//  TagsCollectionView.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 31/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class TagsCollectionView: UICollectionView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !self.bounds.size.equalTo(self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let intrinsicContentSize = self.contentSize
            return intrinsicContentSize
        }
    }
    
    func setup() {
        self.isScrollEnabled = false
        self.bounces = false
    }
}
