//
//  ViewController.swift
//  GoatFinder
//
//  Created by Daniel Hauagge on 3/3/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var goat = Goat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        ageTextField.delegate = self

        nameTextField.text = goat.name
        ageTextField.text = "\(goat.age)"
        
        saveButton.enabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Actions
    @IBAction func saveButtonClicked(sender: AnyObject) {
        
        let goat = Goat()
        
        let realm = try! Realm()
        try! realm.write {
            goat.name = nameTextField.text!
            goat.age = Int(ageTextField.text!)!
            realm.add(goat, update: true)
        }
        print("We have \(realm.objects(Goat).count) goats")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Dismissing the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (!nameTextField.text!.isEmpty && Int(ageTextField.text!) != nil) {
            saveButton.enabled = true
        } else {
            saveButton.enabled = false
        }
    }
}

