//
//  SellList.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import Foundation

import CoreData

struct SellListModel : Codable {
    let id : Int?
    let name : String?
    let price : Int?
    let quantity : Int?
    let type : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case price = "price"
        case quantity = "quantity"
        case type = "type"
    }
    
//    init(entity: ToDo_Interview.SellListEntity) {
//        id = Int(entity.id )
//        name = entity.name
//        price = Int(entity.price)
//        quantity = Int(entity.quantity)
//        type = Int(entity.type)
//    }

    
}