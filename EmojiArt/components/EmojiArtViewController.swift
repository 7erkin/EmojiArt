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
    var emojies: [NSAttributedString] = ["😀", "😆", "😍", "😜", "🤩", "🎃", "😎", "🥂", "🥅", "⚽️", "🏉", "🏀"].attributedString
    var emojiViewsOnArt: [EmojiView] = []
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
    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped(_:)))
            self.scrollView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc
    private func scrollViewTapped(_ gesture: UITapGestureRecognizer) {
        playDownEmojieViews(except: nil)
    }
    
    var imageView = ImageView()
    
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
    
    @IBAction func onAddEmojiesTapped(_ sender: Any) {
        isEmojiAddingModeOn = true
    }
    
    var isEmojiAddingModeOn = false {
        didSet {
            self.emojiCollectionView.reloadItems(at: [.init(item: 0, section: 0)])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? EmojiesInputCollectionViewCell {
            cell.textField.becomeFirstResponder()
        }
    }
}
