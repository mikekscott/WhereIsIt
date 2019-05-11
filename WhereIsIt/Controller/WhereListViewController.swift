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
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    //var alertTextField: UITextField? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        // Do any additional setup after loading the view.
        //recover from personal defaults
        
        readPlist()
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
        //save model
        writePlist()
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
            self.writePlist()
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
    //utility method: add entry to WhereItem model
    func addItem(item:String) {
        let item = WhereItem(item: item, selected: false)
        WhereItemArray.append(item)
    }
    
    //utility method: write WhereItem model to plist
    func writePlist() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(WhereItemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding Array \(error)")
        }
    }
    //utility method: read WhereItem model from plist
    func readPlist(){
        let decoder = PropertyListDecoder()
        
        if let data = try? Data(contentsOf: dataFilePath!){
        do {
            // [WhereItem].self defines the type
            WhereItemArray = try decoder.decode([WhereItem].self, from: data)
        } catch {
            print("Error decoding Plist \(error)")
        }
        }
        
    
        
    }
    
}

