//
//  +UICollectionViewDragDelegate.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension EmojiArtViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: emojies[indexPath.row])
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = self
        return [dragItem]
    }
}
