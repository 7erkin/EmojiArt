//
//  ViewController.swift
//  EmojiArt
//
//  Created by user166334 on 3/16/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import UIKit

class EmojiArtViewController:
    UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDragDelegate, UICollectionViewDropDelegate, UICollectionViewDelegateFlowLayout, UIDropInteractionDelegate {
    private var emojies: [NSAttributedString] = ["😀", "😆", "😍", "😜", "🤩", "🎃", "😎", "🥂", "🥅", "⚽️", "🏉", "🏀"].map{ NSAttributedString(string: $0, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body).withSize(60)]) }
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
    
    private var backgroundImage: UIImage {
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
    
    // MARK: UIDropInteractionDelegate
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        _ = session.loadObjects(ofClass: URL.self) { provider in
            guard let imageUrl = provider.first?.imageUrl else { return }
            
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.backgroundImage = image
                    }
                }
            }
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: URL.self)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
    // MARK: UICollectionViewDragDelegate impl
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: emojies[indexPath.row])
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    // MARK: UICollectionViewDropDelegate impl
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        for item in coordinator.items {
            if let destinationIndexPath = coordinator.destinationIndexPath {
                guard let sourceIndexPath = item.sourceIndexPath else {
                    fatalError("")
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    collectionView.performBatchUpdates({
                        /* Interesting place... */
                        let movedEmoji = self.emojies.remove(at: sourceIndexPath.row)
                        let indexToMove = destinationIndexPath.row
                        self.emojies.insert(movedEmoji, at: indexToMove)
                        collectionView.insertItems(at: [destinationIndexPath])
                        collectionView.deleteItems(at: [sourceIndexPath])
                    })
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        if session.localDragSession == nil {
            return false
        }
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    // MARK: UICollectionViewDataSource impl
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionCell", for: indexPath) as! EmojiCollectionViewCell
        cell.label.attributedText = emojies[indexPath.row]
        return cell
    }
}

extension URL {
    var imageUrl: URL? {
        let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        if let queryItems = urlComponents?.queryItems {
            for item in queryItems {
                if item.name == "imgurl", let value = item.value  {
                    return URL(string: value)
                }
            }
        }
        return nil
    }
}
