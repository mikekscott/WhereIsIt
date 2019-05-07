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
    var archivedObject = Data() // empty byte buffer
    //var WhereItemArray = [["Lawn Mower",false], "Tile Samples", "Board Games","a","b","c","d","e","f","g","h","i","k","l","m","n","o"]
    //set up a user defaults object
    let defaults = UserDefaults.standard
    //var alertTextField: UITextField? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //recover from defaults
        
        if let unarchivedData = defaults.data(forKey: "WhereItemArray") {
            let theString:NSString = NSString(data: unarchivedData, encoding: String.Encoding.ascii.rawValue)!
            
            print("Unarchive: \(theString)")
            //print(items)
            //WhereItemArray = items
            //NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as! [WhereItem]
            //NSKeyedUnarchiver.unarchivedObject(ofClasses: [WhereItem], from: unarchivedData)
            do { try WhereItemArray = NSKeyedUnarchiver.unarchivedObject(ofClasses: [WhereItem], from: unarchivedData) as! [WhereItem]
            } catch let error {
                print("unarchive error: \(error)")
            }
            //NSKeyedUnarchiver.unarchiveObject(with: unarchivedData) as! [WhereItem]
        } else {
            addItem(item: "Lawn Mower")
            addItem(item: "Tile Samples")
            addItem(item: "Board Games")
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
            addItem(item: "o")
           
            
        }
    }
    //MARK - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhereIsItItem", for: indexPath)
        cell.textLabel?.text = WhereItemArray[indexPath.row].item
        // get cell.accessoryType from array
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
        if self.WhereItemArray[indexPath.row].selected {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            self.WhereItemArray[indexPath.row].selected = false
        } else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.WhereItemArray[indexPath.row].selected = true
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Outlet Action for add bar button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        
        
        
        let alert = UIAlertController(title: "Add New WhereIsIt Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success!")
            self.addItem(item: alertTextField.text!)
            //save in defaults
            //let archivedObject = NSKeyedArchiver.archivedData(withRootObject: self.WhereItemArray as NSArray)
            // Serialise Array
            do {
             try self.archivedObject =  NSKeyedArchiver.archivedData(withRootObject: self.WhereItemArray as NSArray, requiringSecureCoding: false)
            } catch let error {
                print("unexpected serialise error \(error)")
            }
            let theString:NSString = NSString(data: self.archivedObject, encoding: String.Encoding.ascii.rawValue)!
            
            print("Archive: \(theString)")
            
            print("Archive: \(self.archivedObject)")
            self.defaults.set(self.archivedObject, forKey: "WhereItemArray")
            //self.defaults.set(self.WhereItemArray, forKey: "WhereItemArray")
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
    
    // utility function to update WhereItemArray
    func addItem(item:String){
        let newItem = WhereItem(item: item, selected: false)
        WhereItemArray.append(newItem)
    }
    

}

