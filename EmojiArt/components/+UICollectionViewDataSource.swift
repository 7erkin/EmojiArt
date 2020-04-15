//
//  +UICollectionViewDataSource.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension EmojiArtViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return emojies.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                if isEmojiAddingModeOn {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiesInputCell", for: indexPath) as! EmojiesInputCollectionViewCell
                    cell.delegate = self
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddEmojiesCell", for: indexPath)
                    cell.backgroundColor = .green
                    return cell
                }
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionCell", for: indexPath) as! EmojiCollectionViewCell
                cell.label.attributedText = emojies[indexPath.row]
                cell.backgroundColor = .green
                return cell
            default:
                fatalError("UB")
        }
    }
}
