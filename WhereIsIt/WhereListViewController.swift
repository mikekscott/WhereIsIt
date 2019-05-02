//
//  ViewController.swift
//  WhereIsIt
//
//  Created by Mike Scott on 25/04/2019.
//  Copyright © 2019 Mike Scott. All rights reserved.
//

import UIKit

class WhereListViewController: UITableViewController {
    var WhereItemArray = ["Lawn Mower", "Tile Samples", "Board Games"]
    //var alertTextField: UITextField? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhereIsItItem", for: indexPath)
        cell.textLabel?.text = WhereItemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WhereItemArray.count
    }
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(WhereItemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Outlet Action for add bar button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New WhereIsIt Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success!")
            self.WhereItemArray.append( alertTextField.text!)
            //self.messageTableView.reloadData()
            self.tableView.insertRows(at: [IndexPath(row: self.WhereItemArray.count-1, section: 0)], with: .automatic)
            self.view.layoutIfNeeded()
            //print(alertTextField.text!)
        }
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "Add New Item"
            alertTextField = AlertTextField
        }
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        //self.present(alert, animated: true) {
       //     print(self.alertTextField!.text!)
      //  }
        
    }
    

}

