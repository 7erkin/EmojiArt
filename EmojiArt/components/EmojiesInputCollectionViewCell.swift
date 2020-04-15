//
//  EmojiesInputCollectionViewCell.swift
//  EmojiArt
//
//  Created by Олег Черных on 15/04/2020.
//  Copyright © 2020 user166334. All rights reserved.
//

import UIKit

protocol EmojiesAdding: class {
    func add(emojies: [String])
}

class EmojiesInputCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    @IBOutlet var textField: UITextField! {
        didSet {
            self.textField.delegate = self
            self.textField.font = UIFont.preferredFont(forTextStyle: .body).withSize(40)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            return !text.contains(string)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            delegate?.add(emojies: text.map { String($0) })
            textField.text = nil
        }
    }
    
    weak var delegate: EmojiesAdding?
}
