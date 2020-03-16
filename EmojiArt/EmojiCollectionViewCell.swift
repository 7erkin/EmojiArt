//
//  EmojiCollectionViewCell.swift
//  EmojiArt
//
//  Created by user166334 on 3/16/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
    }
}
