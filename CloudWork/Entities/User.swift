//
//  User.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 29/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var id: Int
    var name: String
    var twitter: String
    var pictureURL: String
    var email: String
    var password: String?
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case twitter
        case pictureURL
        case email
        case password
        case createdAt
    }
}
