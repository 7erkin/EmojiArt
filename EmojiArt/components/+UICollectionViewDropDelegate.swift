//
//  +UICollectionViewDropDelegate.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension EmojiArtViewController: UICollectionViewDropDelegate {
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
}
