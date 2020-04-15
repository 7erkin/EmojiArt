//
//  UICollectionViewFlowDelegateLayout.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension EmojiArtViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSide = collectionView.bounds.height
        if indexPath.section == 0 && collectionView.cellForItem(at: indexPath) is EmojiesInputCollectionViewCell {
            return CGSize(width: 7 * itemSide, height: itemSide)
        }
        return CGSize(width: itemSide, height: itemSide)
    }
}
