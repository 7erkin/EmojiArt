//
//  +UIDropInteractionDelegate.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation
import UIKit

extension EmojiArtViewController {
    func createEmojiView(with symbol: NSAttributedString) -> EmojiView {
        let view = EmojiView()
        view.delegate = self
        view.symbol = symbol
        return view
    }
    
    func playDownEmojieViews(except: ((EmojiView) -> Bool)?) {
        let playDownEmojieView: (EmojiView) -> Void = { $0.isHighlighted = false }
        if except == nil {
            droppedEmojies.forEach(playDownEmojieView)
        } else {
            droppedEmojies.forEachWhere(predicate: { except!($0) }, playDownEmojieView)
        }
    }
}

extension EmojiArtViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if let _ = session.localDragSession?.localContext as? EmojiArtViewController {
            let dropPoint = session.location(in: dropZoneView)
            _ = session.loadObjects(ofClass: NSAttributedString.self) { provider in
                if let symbol = provider.first as? NSAttributedString {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        let emojiView = self.createEmojiView(with: symbol)
                        self.imageView.addSubview(emojiView)
                        self.droppedEmojies.append(emojiView)
                        emojiView.frame.origin = dropPoint
                    }
                }
            }
        }
        
        _ = session.loadObjects(ofClass: URL.self) { provider in
            guard let imageUrl = provider.first?.imageUrl else { return }
            
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.backgroundImage = image
                    }
                }
            }
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: URL.self) || session.canLoadObjects(ofClass: NSAttributedString.self)
    }
}
