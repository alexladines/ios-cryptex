//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Alex Ladines on 5/1/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController {
    
    // MARK: - Properties
    var cryptexController = CryptexController()
    let letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
    // MARK: - Outlets
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var letterGuesserPickerView: UIPickerView!
    @IBOutlet weak var unlockButton: UIButton!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set this instance to delegate and data source of picker
        self.letterGuesserPickerView.dataSource = self
        self.letterGuesserPickerView.delegate = self
        
        // Update Views
        self.updateViews()
    }
    
    // MARK: - IBAction
    @IBAction func unlockButtonPressed(_ sender: Any) {
        // Test hasMatchingPassword()
        print(self.hasMatchingPassword())
        
        self.updateViews()
        
    }
    
    // MARK: - Class Methods
    func updateViews() {
        // Get random cryptex
        cryptexController.setRandomCryptex()
        
        guard let cryptex = cryptexController.currentCryptex else { return }
        
        hintLabel.text = cryptex.hint
        
        // Reload the components of the picker view so that when a new random cryptex is started, the picker view will update the number of components.
        self.letterGuesserPickerView.reloadAllComponents()
    }
    
    // MARK: - Game Logic
    func hasMatchingPassword() -> Bool {
        
        guard let cryptex = cryptexController.currentCryptex else { return false }
        
        // Chosen letters will go in here
        var pickerLetterChoices: [Character] = []
        
        // Number of letters in password = number of picker components
        for (index,_) in cryptex.password.enumerated()
        {
            // Chosen letter
            let chosenLetter = self.letters[self.letterGuesserPickerView.selectedRow(inComponent: index)]
            
            // Append letter to chosen letters array
            pickerLetterChoices.append(Character(chosenLetter))
        }
        
        // Compare password and picker letters
        return cryptex.password.lowercased() == String(pickerLetterChoices).lowercased()
    }

}
// MARK: - UIPickerViewDataSource
extension CryptexViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // For the number of components, think about how you can figure out how many characters are in the `currentCryptex`'s password.
        return cryptexController.currentCryptex?.numChars ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // For the number of rows, we want to show as many rows as there are letters.
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // For the title of each row, we want to show the letter that corresponds to the row. i.e. row 0 should show "A", row 1 should show "B", etc.
        return letters[row]
    }

    
}
// MARK: - UIPickerViewDelegate
extension CryptexViewController: UIPickerViewDelegate {
    
}


