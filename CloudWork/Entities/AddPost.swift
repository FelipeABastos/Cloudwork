//
//  addPost.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 30/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct AddPost: Codable {
    
    var imageFile: Data?
    var id_user: Int!
    var text: String?
    
    enum CodingKeys: String, CodingKey {
        
        case imageFile
        case id_user
        case text
    }
}
