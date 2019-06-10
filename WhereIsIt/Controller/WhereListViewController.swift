//
//  ViewController.swift
//  WhereIsIt
//
//  Created by Mike Scott on 25/04/2019.
//  Copyright © 2019 Mike Scott. All rights reserved.
//

import UIKit
import CoreData

class WhereListViewController: UITableViewController {
    //array holds DataModel Entities - we called it Item
    var WhereItemArray = [Item]()
    //can reference appdelegate instance using a singleton supplied when application runs
    // the context is the key item you interact with for a datastore and is described as a scratch pad
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var searchBar: UISearchBar!
    
    //var alertTextField: UITextField? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // print documents data file path
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       
        // Do any additional setup after loading the view.
        //recover from personal defaults
        
        readItems()
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
//        rowItem.selected = !rowItem.selected //toggle boolean
//        //Populate accessory type
//        tableView.cellForRow(at: indexPath)?.accessoryType = rowItem.selected ? .checkmark : .none
//        //fades out selection
//        tableView.deselectRow(at: indexPath, animated: true)
//        //save model
        // select and delete
        context.delete(rowItem)
        WhereItemArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        saveItems()
    }
    
    //MARK - Outlet Action for add bar button
    // creates an alert with text input
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        //var whereItems = [String]()
        //var whereSelected = [Bool]()
        
        
        //alert
        let alert = UIAlertController(title: "Add New WhereIsIt Item", message: "", preferredStyle: .alert)
        //action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success!")
            //add new item to array
            self.addItem(itemText: alertTextField.text!)
            
         
            //save in defaults
            self.saveItems()
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
    func addItem(itemText:String) {

        // context initialised at start of class

        let item = Item(context: context)
        item.item = itemText
        item.selected = false
        
        
      //  let item = WhereItem(item: item, selected: false)
        WhereItemArray.append(item)
    }
    
    //utility method: write WhereItem model to plist
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    //utility method: read WhereItem model from plist
    //note default parameter is Item.fetchRequest()
    // All items
    func readItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
        do {
            WhereItemArray = try context.fetch(request)
        } catch {
            print("error fetching Items \(error)")
        }

        }
//
//
//
//    }

}
//MARK: searchBarDelegate
extension WhereListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //create CoreData fetch request
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        //create a search predicate
        if searchBar.text != "" {
            
        
        request.predicate = NSPredicate(format: "item CONTAINS[cd] %@", searchBar.text!)
        }
        
        //create a sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "item", ascending: true)]
       
        readItems(with: request)
        tableView.reloadData()
        print(searchBar.text ?? "EMPTY")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // zero text indicates search cancelled
        if searchText.count == 0 {
            readItems()
            tableView.reloadData()
            //tells searchbar to relinquish focus
            //this request has to be dispatched to main
            // thread
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            }
            
        }
    }
    
}

