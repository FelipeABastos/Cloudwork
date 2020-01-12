//
//  Util.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 12/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class Util {
    
    static func validate(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    static func tintPlaceholder(field: UITextField, color: UIColor) {
        if let placeholder = field.placeholder {
            field.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6)])
        }
    }
    
}
