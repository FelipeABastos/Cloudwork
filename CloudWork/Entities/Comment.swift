//
//  File.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 21/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

struct Comment: Codable {
    
    var id: Int!
    var text: String!
    var time: String!
    
    var amountLikes: Int!
    var aumontComments: Int!
    
    var author: Author!
}
