//
//  CryptexController.swift
//  Cryptex
//
//  Created by Alex Ladines on 5/1/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import Foundation

class CryptexController {
    private(set) var cryptexes: [Cryptex] = []
    var currentCryptex: Cryptex?
    
    init() {
        let cryptex1 = Cryptex(password: "Let", hint: "How do you declare a constant in swift?")
        let cryptex2 = Cryptex(password: "Sacramento", hint: "This is the capital of California.")
        let cryptex3 = Cryptex(password: "Git", hint: "This is like a giant undo button for your Xcode project.")
        cryptexes.append(cryptex1)
        cryptexes.append(cryptex2)
        cryptexes.append(cryptex3)
        
        self.setRandomCryptex()
    }
    
    // Return a random cryptex
    func setRandomCryptex() {
        self.currentCryptex = cryptexes.randomElement()
    }
    
}
