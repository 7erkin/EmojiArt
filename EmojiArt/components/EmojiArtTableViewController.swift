//
//  EmojiArtTableViewController.swift
//  EmojiArt
//
//  Created by Олег Черных on 15/04/2020.
//  Copyright © 2020 user166334. All rights reserved.
//

import UIKit

class EmojiArtTableViewController: UITableViewController {
    private var names = ["First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}
