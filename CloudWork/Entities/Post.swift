//
//  Post.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 17/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    var id: Int!
    var text: String!
    var imageURL: String!
    var time: String!
    
    var amountLikes: Int!
    var amountComments: Int!
    
    var author: Author!
    
    var comments: Array<Comment>!
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case text = "content"
        case imageURL
        case time
        
        case amountLikes = "likes"
        case amountComments = "comments"
        case comments = "arrayComments"
        
        case author
        
    }
    
}




