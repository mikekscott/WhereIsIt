//
//  WhereItem.swift
//  WhereIsIt
//
//  Created by Mike Scott on 05/05/2019.
//  Copyright © 2019 Mike Scott. All rights reserved.
//
import Foundation
class WhereItem : NSObject, NSCoding{
// Class implements Serialisation NSCoding Protocol
    var item: String = ""
    var selected: Bool = false
    
    //Serialise
    func encode(with aCoder: NSCoder) {
        aCoder.encode(item, forKey: "item")
        aCoder.encode(selected, forKey: "selected")
    }
    
    //DeSerialise
    required init?(coder aDecoder: NSCoder) {
        item = aDecoder.decodeObject(forKey: "item") as? String ?? "empty string"
        selected = aDecoder.decodeObject(forKey: "selected") as? Bool ?? false
        print("deserialise \(item) : \(selected)")
        
    }
    
 // Normal init
    init(item:String, selected:Bool) {
        self.item = item
        self.selected = selected
    }
    
}
