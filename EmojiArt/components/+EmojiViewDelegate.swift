//
//  +EmojiViewDelegate.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension EmojiArtViewController: EmojiViewDelegate {
    func tap(_ gesture: UITapGestureRecognizer) {
        let view = gesture.view as! EmojiView
        playDownEmojieViews(except: { $0 != view })
        view.isHighlighted = !view.isHighlighted
    }
    
    func scale(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            
        }
    }
    
    func move(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let view = gesture.view as! EmojiView
            if view.isHighlighted {
                let shift = gesture.translation(in: view)
                view.frame.origin += shift
                gesture.setTranslation(.zero, in: view)
            }
        }
    }
}
