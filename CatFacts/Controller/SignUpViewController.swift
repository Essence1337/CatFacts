//
//  SignUpViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import RealmSwift
import ValidationComponents

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var regMailTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var regPassTextField: UITextField!
    @IBOutlet weak var regConfirmPassTextField: UITextField!
    
    // MARK: - Properties
    let realm = try! Realm()
    let alert = AlertView()
    let predicate = EmailValidationPredicate()
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        regMailTextField.delegate = self
        regPassTextField.delegate = self
        regConfirmPassTextField.delegate = self
        
        SetUpOutlets()
        notifications1()
    }
    
    func writeToDB() {
        let myUsers = Users()
        let results = realm.objects(Users.self)
        let userEmail = regMailTextField.text
        let userPass = regPassTextField.text
        let userPassConfirm = regConfirmPassTextField.text
        
        let emailFormatBool = predicate.evaluate(with: userEmail)
        
        // Email validation.
        if (!emailFormatBool) {
            moveTextField( -100, up: true)
            alert.showAlert(view: self, title: "Incorrect input", message: "Email format not correct!")
            
            return
        }
        
        // Unique user check.
        for i in 0..<results.count {
            if (results[i].email == regMailTextField.text){
                moveTextField( -100, up: true)
                alert.showAlert(view: self, title: "Incorrect input", message: "User already exist!")
                
                return
            } else {
                print("EMAIL IS UNIQUE")
            }
        }
        
        // Password isEmpty check.
        if (userPass!.isEmpty || userPassConfirm!.isEmpty) {
            moveTextField( -100, up: true)
            alert.showAlert(view: self, title: "Incorrect input", message: "Enter Password")
            
            return
        } else {
            // Password length check.
            if (userPass!.count < 6) {
                moveTextField( -100, up: true)
                alert.showAlert(view: self, title: "Incorrect input", message: "Password shoud be more than 5 characters!")
                
                return
            }
        }
        
        // Passwords match check.
        if (userPass != userPassConfirm) {
            moveTextField( -100, up: true)
            alert.showAlert(view: self, title: "Incorrect input", message: "Passwords are not the same!")
            
            return
        } else {
            saveLoggedState()
            performSegue(withIdentifier: "goToTableFromSignUp", sender: self)
        }
        
        myUsers.email = userEmail
        myUsers.password = userPass
        
        try! realm.write {
            realm.add(myUsers)
        }
    }
    
    // Save authorize state.
    func saveLoggedState() {
        let def = UserDefaults.standard
        def.set(true, forKey: "isLoggedIn")
        def.synchronize()
    }
    
    // MARK: - Actions
    @IBAction func registerButtonAction(_ sender: Any) {
        dismissKeyboard()
        writeToDB()
    }
    
    //SetUpOutlets
    private func SetUpOutlets() {
        regMailTextField.layer.cornerRadius = 5
        regMailTextField.layer.borderWidth = 0.5
        regMailTextField.layer.borderColor = UIColor.gray.cgColor
        regMailTextField.textContentType = UITextContentType(rawValue: "")
        
        regPassTextField.layer.cornerRadius = 5
        regPassTextField.layer.borderWidth = 0.5
        regPassTextField.layer.borderColor = UIColor.gray.cgColor
        regPassTextField.textContentType = UITextContentType(rawValue: "")
        
        regConfirmPassTextField.layer.cornerRadius = 5
        regConfirmPassTextField.layer.borderWidth = 0.5
        regConfirmPassTextField.layer.borderColor = UIColor.gray.cgColor
        regConfirmPassTextField.textContentType = UITextContentType(rawValue: "")
        
        registerButtonOutlet.layer.cornerRadius = 5
        registerButtonOutlet.layer.borderWidth = 0.5
        registerButtonOutlet.layer.borderColor = UIColor.gray.cgColor
    }
    
    func notifications1() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let notifier1 = NotificationCenter.default
        notifier1.addObserver(self,
                              selector: #selector(keyboardWillShowNotification(_:)),
                              name: UIWindow.keyboardWillShowNotification,
                              object: nil)
        notifier1.addObserver(self,
                              selector: #selector(keyboardWillHideNotification(_:)),
                              name: UIWindow.keyboardWillHideNotification,
                              object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            dismissKeyboard()
        }
    }
    
    //Move view UP when keyboard appears
    @objc func keyboardWillShowNotification(_ notification: NSNotification) {
        moveTextField( -100, up: true)
    }
    
    //Move view DOWN when keyboard gone
    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        moveTextField( -100, up: false)
    }
    
    //Move view when keyboar appears
    func moveTextField(_ moveDistance: Int, up: Bool) {
        let moveDuration = 0.2
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    // Hide Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
