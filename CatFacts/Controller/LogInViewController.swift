//
//  LogInViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import RealmSwift
import ValidationComponents

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var logInButtonOutlet: UIButton!
    @IBOutlet weak var goToSignUpButtonOutlet: UIButton!
    
    // MARK: - Properties
    let realm = try! Realm()
    let alert = AlertView()
    let predicate = EmailValidationPredicate()

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        emailTextFieldOutlet.delegate = self
        passwordTextFieldOutlet.delegate = self
        SetUpOutlets()
        dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }
    
    // Validate user.
    func validateUser() {
        
        let results = realm.objects(Users.self)
        let userEmail = emailTextFieldOutlet.text
        let userPass = passwordTextFieldOutlet.text
        let emailFormatBool = predicate.evaluate(with: userEmail)
        var emailMatch = false
        var passMatch = false
        
        // Email isEmpty check.
        if (userEmail!.isEmpty) {
            alert.showAlert(view: self, title: "Incorrect input", message: "Enter Email!")
            
            return
        } else {
            // Email validation.
            if (!emailFormatBool) {
                alert.showAlert(view: self, title: "Incorrect input", message: "Email format not correct!")
                
                return
            }
        }
        
        // Password isEmpty check.
        if (userPass!.isEmpty) {
            alert.showAlert(view: self, title: "Incorrect input", message: "Enter password!")
            
            return
        } else {
            // Password length check.
            if (userPass!.count < 6) {
                alert.showAlert(view: self, title: "Incorrect input", message: "Password shoud be more than 5 characters!")
                
                return
            }
        }
        // Email and password match.
        for i in 0..<results.count {
            if (results[i].email == userEmail){
                emailMatch = true
                
                if (results[i].password == userPass) {
                    passMatch = true
                }
            }
        }
        
        if (emailMatch) {
            if (passMatch) {
                // Email and password correct.
                performSegue(withIdentifier: "goToTableFromLogIn", sender: self)
                saveLoggedState()
            } else {
                // Password is wrong.
                alert.showAlert(view: self, title: "Incorrect input", message: "Wrong password!")
                
                return
            }
        } else {
            // Email is wrong.
            alert.showAlert(view: self, title: "Incorrect input", message: "Wrong email!")
            
            return
        }
    }
    
    // Save authorize state.
    func saveLoggedState() {
        let def = UserDefaults.standard
        def.set(true, forKey: "isLoggedIn")
        def.synchronize()
    }
    
    // MARK: - Actions
    @IBAction func logInButtonAction(_ sender: Any) {
        dismissKeyboard()
        validateUser()
    }
    
    @IBAction func goToSignUpButtonAction(_ sender: Any) {
        dismissKeyboard()
    }
    
    // SetUpOutlets
    func SetUpOutlets() {
        emailTextFieldOutlet.layer.cornerRadius = 5
        emailTextFieldOutlet.layer.borderWidth = 0.5
        emailTextFieldOutlet.layer.borderColor = UIColor.gray.cgColor
        emailTextFieldOutlet.textContentType = UITextContentType(rawValue: "")
        
        passwordTextFieldOutlet.layer.cornerRadius = 5
        passwordTextFieldOutlet.layer.borderWidth = 0.5
        passwordTextFieldOutlet.layer.borderColor = UIColor.gray.cgColor
        passwordTextFieldOutlet.isSecureTextEntry = true
        passwordTextFieldOutlet.textContentType = UITextContentType(rawValue: "")
        
        
        logInButtonOutlet.layer.cornerRadius = 5
        logInButtonOutlet.layer.borderWidth = 0.5
        logInButtonOutlet.layer.borderColor = UIColor.gray.cgColor
    }
    
    // Notifications for moving view when keyboard appears.
    func setUpNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Removing notifications.
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Move view back when keyboard hide.
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if passwordTextFieldOutlet.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            } else if emailTextFieldOutlet.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }
    }
    
    // Hide keyboard on tap.
    func dismissKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // Hide Keyboard.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Hide the keyboard when the return key pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
