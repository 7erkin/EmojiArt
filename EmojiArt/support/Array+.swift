//
//  Array+.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    func forEachWhere(predicate: (Element) -> Bool, _ body: (Element) throws -> Void) rethrows {
        for el in self where predicate(el) {
            try body(el)
        }
    }
}

extension Array where Element == NSAttributedString {
    func differenceWith(_ array: [NSAttributedString]) -> [NSAttributedString] {
        return self.filter { !array.contains($0) }
    }
}

extension Array where Element == String {
    var attributedString: [NSAttributedString] {
        return self.map { NSAttributedString(string: $0, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body).withSize(60)]) }
    }
}
