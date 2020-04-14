//
//  ViewController.swift
//  EmojiArt
//
//  Created by user166334 on 3/16/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import UIKit

class EmojiArtViewController:
    UIViewController, UICollectionViewDelegate {
    var emojies: [NSAttributedString] = ["😀", "😆", "😍", "😜", "🤩", "🎃", "😎", "🥂", "🥅", "⚽️", "🏉", "🏀"].map{ NSAttributedString(string: $0, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body).withSize(60)]) }
    @IBOutlet var emojiCollectionView: UICollectionView! {
        didSet {
            self.emojiCollectionView.delegate = self
            self.emojiCollectionView.dataSource = self
            self.emojiCollectionView.dragDelegate = self
            self.emojiCollectionView.dropDelegate = self
        }
    }
    @IBOutlet var dropZoneView: UIView! {
        didSet {
            let dropInteraction = UIDropInteraction(delegate: self)
            self.dropZoneView.addInteraction(dropInteraction)
        }
    }
    @IBOutlet var scrollView: UIScrollView!
    private var imageView = ImageView()
    
    var backgroundImage: UIImage {
        set {
            let imageSize = newValue.size
            imageView.image = newValue
            scrollView.addSubview(imageView)
            scrollView.contentSize = imageSize
            imageView.frame = CGRect(origin: .zero, size: imageSize)
        }
        get {
            self.imageView.image
        }
    }
}
