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
        // Actutal game data
//        let cryptex1 = Cryptex(password: "MAGA", hint: "President Trump's slogan.")
//        let cryptex2 = Cryptex(password: "Beef", hint: "The healthiest food in the world.")
//        let cryptex3 = Cryptex(password: "Xcode", hint: "Apple's IDE.")

        
        // Testing data
        let cryptex1 = Cryptex(password: "A", hint: "A")
        let cryptex2 = Cryptex(password: "Ab", hint: "AB")
        let cryptex3 = Cryptex(password: "Abc", hint: "ABC")
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
