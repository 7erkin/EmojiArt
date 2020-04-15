//
//  +EmojiesAdding.swift
//  EmojiArt
//
//  Created by Олег Черных on 16/04/2020.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation

extension EmojiArtViewController: EmojiesAdding {
    func add(emojies: [String]) {
        self.emojies = emojies.attributedString.differenceWith(self.emojies) + self.emojies
        isEmojiAddingModeOn = false
    }
}
