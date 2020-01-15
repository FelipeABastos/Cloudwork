//
//  PersistManager.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 15/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

class PersistManager {
    
    static func get() -> Array<Dictionary<String, String>> {
        
        var users: Array<Dictionary<String, String>> = []
        if let array = UserDefaults.standard.array(forKey: Constants.Key.users) as? Array<Dictionary<String, String>> {
            users = array
        }
        
        return users
    }
    
    static func set(data: Dictionary<String, String>) {
        
        var users: Array<Dictionary<String, String>> = []
        if let array = UserDefaults.standard.array(forKey: Constants.Key.users) as? Array<Dictionary<String, String>> {
            users = array
        }

        users.append(data)

        UserDefaults.standard.set(users, forKey: Constants.Key.users)
    }
}
