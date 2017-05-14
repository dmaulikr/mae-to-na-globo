//
//  MemoriesViewController.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/14/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit

class MemoriesViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "MemoryCell")!
    }
    
}
