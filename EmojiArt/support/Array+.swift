//
//  Array+.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation

extension Array {
    func forEachWhere(predicate: (Element) -> Bool, _ body: (Element) throws -> Void) rethrows {
        for el in self where predicate(el) {
            try body(el)
        }
    }
}
