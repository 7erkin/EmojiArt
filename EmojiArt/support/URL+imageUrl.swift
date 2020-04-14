//
//  URL+imageUrl.swift
//  EmojiArt
//
//  Created by user166334 on 4/14/20.
//  Copyright © 2020 user166334. All rights reserved.
//

import Foundation

extension URL {
    var imageUrl: URL? {
        let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        if let queryItems = urlComponents?.queryItems {
            for item in queryItems {
                if item.name == "imgurl", let value = item.value  {
                    return URL(string: value)
                }
            }
        }
        return nil
    }
}
