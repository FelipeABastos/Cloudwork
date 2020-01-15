//
//  Session.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 15/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

class Session {
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: Constants.Key.loggedUser)
    }
    
    static func get() -> Dictionary<String, String>? {
        return UserDefaults.standard.dictionary(forKey: Constants.Key.loggedUser) as? Dictionary<String, String>
    }
    
    static func set(data: Dictionary<String, String>) {
        UserDefaults.standard.set(data, forKey: Constants.Key.loggedUser)
        UserDefaults.standard.synchronize()
    }
    
}
