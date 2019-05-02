//
//  Cyptex.swift
//  Cryptex
//
//  Created by Alex Ladines on 5/1/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import Foundation

class Cryptex {
    var password: String
    var hint: String
    var numChars: Int {
        get {
            return password.count
        }
    }
    
    init(password: String, hint: String){
        self.password = password
        self.hint = hint
    }
    
}
