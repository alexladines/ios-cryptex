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
    var countdownTimer:Timer?
    
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
        // print(self.hasMatchingPassword())
        
        self.hasMatchingPassword() ? self.presentCorrectPasswordAlert() : self.presentIncorrectPasswordAlert()
    }
    
    // MARK: - Class Methods
    func updateViews() {
        // Get random cryptex
        //cryptexController.setRandomCryptex() Might be redundant after method below
        
        guard let cryptex = cryptexController.currentCryptex else { return }
        
        hintLabel.text = cryptex.hint
        
        // Reload the components of the picker view so that when a new random cryptex is started, the picker view will update the number of components.
        self.letterGuesserPickerView.reloadAllComponents()
    }
    
    func newCryptexAndReset() {
        // Get random cryptex
        self.cryptexController.setRandomCryptex()
        
        // Update views and components of picker
        self.updateViews()
        
        // Reset timer
        self.reset()
    }
    
    // MARK: - Button Helper Functions
    
    // Guessed the right password
    private func presentCorrectPasswordAlert() {
        let alert = UIAlertController(title: "Congratulations!", message: "You have guessed the correct password.\n Would you like to play again?", preferredStyle: .alert)
        let action = UIAlertAction(title: "New Cryptex", style: .default, handler: {_ in self.newCryptexAndReset()} )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // Guessed the wrong password
    private func presentIncorrectPasswordAlert() {
        let alert = UIAlertController(title: "Not Quite!", message: "Would you like to keep guessing, or try a new cryptex?", preferredStyle: .alert)
        let keepGuessingAction = UIAlertAction(title: "Keep Guessing", style: .default, handler: nil)
        let newCryptexAction = UIAlertAction(title: "New Cryptex", style: .default, handler: {_ in self.newCryptexAndReset()})
        alert.addAction(keepGuessingAction)
        alert.addAction(newCryptexAction)
        present(alert, animated: true, completion: nil)
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

    // MARK: - Timer
    func reset() {
        
        // If an old timer exists, invalidate it
        if let oldTimerExists = self.countdownTimer
        {
            oldTimerExists.invalidate()
        }
        
        // Create a new timer
        self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { timer in
            print("Timer fired!")
        }
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


