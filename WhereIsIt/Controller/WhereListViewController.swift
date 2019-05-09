//
//  ViewController.swift
//  WhereIsIt
//
//  Created by Mike Scott on 25/04/2019.
//  Copyright © 2019 Mike Scott. All rights reserved.
//

import UIKit

class WhereListViewController: UITableViewController {
    var WhereItemArray = [WhereItem]()
    //set up a user defaults object
    let defaults = UserDefaults.standard
    //var alertTextField: UITextField? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //recover from defaults else populate with some initial values
        //note defaults can't contain objects so convert to ints and bools
        if let items = defaults.array(forKey: "WhereItemArray") as? [String] {
            print(items)
            let selected = defaults.array(forKey: "WhereSelectedArray") as! [Bool]
            for (index, anItem) in items.enumerated(){
                addItem(item: anItem)
                WhereItemArray[index].selected = selected[index]
                
            }
            
        } else {
            addItem(item: "Books")
            addItem(item: "Plates")
            addItem(item: "Food")
            addItem(item: "a")
            addItem(item: "b")
            addItem(item: "c")
            addItem(item: "d")
            addItem(item: "e")
            addItem(item: "f")
            addItem(item: "g")
            addItem(item: "h")
            addItem(item: "i")
            addItem(item: "j")
            addItem(item: "k")
            addItem(item: "l")
            addItem(item: "m")
            addItem(item: "n")
        }
    }
    //MARK - TableView Data Source Methods
    //populate rows from model
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhereIsItItem", for: indexPath)
        let rowItem = WhereItemArray[indexPath.row]
    // Populate with item name
        cell.textLabel?.text = rowItem.item
    // populate accessory
        cell.accessoryType = rowItem.selected ? .checkmark : .none
  
        return cell
    }
     //return number of table rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WhereItemArray.count
    }
    
    //MARK - TableView Delegate Methods
    //Called when row selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowItem = WhereItemArray[indexPath.row]
        rowItem.selected = !rowItem.selected //toggle boolean
        //Populate accessory type
        tableView.cellForRow(at: indexPath)?.accessoryType = rowItem.selected ? .checkmark : .none
        //fades out selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Outlet Action for add bar button
    // creates an alert with text input
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        var whereItems = [String]()
        var whereSelected = [Bool]()
        
        //alert
        let alert = UIAlertController(title: "Add New WhereIsIt Item", message: "", preferredStyle: .alert)
        //action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success!")
            //add new item to array
            self.addItem(item: alertTextField.text!)
            
            //unpack WhereItemsArray
            for item in self.WhereItemArray {
                whereItems.append(item.item)
                whereSelected.append(item.selected)
            }
            
            //save in defaults
            self.defaults.set(whereItems, forKey: "WhereItemArray")
            self.defaults.set(whereSelected, forKey: "WhereSelectedArray")
            //self.messageTableView.reloadData()
            // no need to reload whole table if insertRows used
            self.tableView.insertRows(at: [IndexPath(row: self.WhereItemArray.count-1, section: 0)], with: .automatic)
            self.view.layoutIfNeeded()
            //print(alertTextField.text!)
        }
        //Add text Field to alert
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "Add New Item"
            alertTextField = AlertTextField
        }
        // Add action to alert
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        //self.present(alert, animated: true) {
        //     print(self.alertTextField!.text!)
        //  }
        
    }
    //utility class: add entry to WhereItemArray
    func addItem(item:String) {
        let item = WhereItem(item: item, selected: false)
        WhereItemArray.append(item)
    }
    
    
}

