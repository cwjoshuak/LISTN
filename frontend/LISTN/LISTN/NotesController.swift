//
//  NotesController.swift
//  LISTN
//
//  Created by Joshua Kuan on 28/04/2018.
//  Copyright © 2018 Joshua Kuan. All rights reserved.
//

import UIKit

class NotesController: UITableViewController {

    let itemArray = ["One", "Two", "Three"]
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath) as! NoteTBCell
        cell.timeLabel.text = "Today"
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }


}
