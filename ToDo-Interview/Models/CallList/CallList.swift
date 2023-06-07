//
//  CallList.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import Foundation


struct CallList : Codable {
    let id : Int?
    let name : String?
    let number : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case number = "number"
    }


}
