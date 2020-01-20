//
//  Post.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 17/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    var text: String!
    var imageURL: String?
    var time: String!
    
    var likes: Int!
    var comments: Int!
    
    var author: Author!
}



