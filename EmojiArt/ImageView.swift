//
//  ImageView.swift
//  EmojiArt
//
//  Created by user166334 on 3/16/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import UIKit

class ImageView: UIView {
    var image: UIImage! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if let image = image {
            image.draw(in: rect)
        }
    }
}
