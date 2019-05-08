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
        //recover from defaults
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhereIsItItem", for: indexPath)
        cell.textLabel?.text = WhereItemArray[indexPath.row].item
        if WhereItemArray[indexPath.row].selected {
            cell.accessoryType = .checkmark
        } else {
        cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WhereItemArray.count
    }
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(WhereItemArray[indexPath.row])
        if WhereItemArray[indexPath.row].selected
     {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        WhereItemArray[indexPath.row].selected = false
        } else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            WhereItemArray[indexPath.row].selected = true
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Outlet Action for add bar button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        var whereItems = [String]()
        var whereSelected = [Bool]()
        
        
        let alert = UIAlertController(title: "Add New WhereIsIt Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success!")
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
    //utility class: add entry to WhereItemArray
    func addItem(item:String) {
        let item = WhereItem(item: item, selected: false)
        WhereItemArray.append(item)
    }
    

}

