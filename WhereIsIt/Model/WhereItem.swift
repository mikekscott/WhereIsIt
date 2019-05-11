//
//  WhereItem.swift
//  WhereIsIt
//
//  Created by Mike Scott on 05/05/2019.
//  Copyright © 2019 Mike Scott. All rights reserved.
//
import Foundation
class WhereItem : Codable{

    var item: String = ""
    var selected: Bool = false
    
    init(item:String, selected:Bool) {
        self.item = item
        self.selected = selected
    }
    
}
