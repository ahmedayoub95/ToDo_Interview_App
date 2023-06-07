//
//  NSManagedObjectClass.swift
//  ToDo-Interview
//
//  Created by Ahmed-SolutionInn on 07/06/2023.
//

import Foundation
import CoreData

class SellListItem: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var price: Int
    @NSManaged var quantity: Int
    @NSManaged var type: Int
    
    
}
