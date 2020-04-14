//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol EmojiViewDelegate: class {
    func tap(_ gesture: UITapGestureRecognizer)
    func scale(_ gesture: UIPinchGestureRecognizer)
    func move(_ gesture: UIPanGestureRecognizer)
}

class EmojiView: UIView {
    var symbol: NSAttributedString! {
        didSet {
            let label = UILabel()
            label.attributedText = self.symbol
            self.addSubview(label)
            let frame = CGRect(
                origin: self.frame.origin,
                size: symbol.boundingRect(
                    with: .init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                    options: .usesLineFragmentOrigin, context: nil
                ).size
            )
            self.frame = frame
        }
    }
    
    weak var delegate: EmojiViewDelegate? {
        didSet {
            let gestures = [
                UITapGestureRecognizer(target: self, action: #selector(tap(_:))),
                UIPinchGestureRecognizer(target: self, action: #selector(scale(_:))),
                UIPanGestureRecognizer(target: self, action: #selector(move(_:)))
            ]
            gestures.forEach{ self.addGestureRecognizer($0) }
        }
    }
    
    @objc
    private func tap(_ gesture: UITapGestureRecognizer) {
        delegate?.tap(gesture)
    }
    
    @objc
    private func scale(_ gesture: UIPinchGestureRecognizer) {
        delegate?.scale(gesture)
    }
    
    @objc
    private func move(_ gesture: UIPanGestureRecognizer) {
        delegate?.move(gesture)
    }
    
    var isHighlighted: Bool = false {
        didSet {
            if self.isHighlighted {
                self.layer.borderWidth = 5.0
                self.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    override func layoutSubviews() {
        subviews.first!.frame = bounds
    }
}
