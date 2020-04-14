//
//  CGPoint++.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}
