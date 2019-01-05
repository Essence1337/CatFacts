//
//  SignUpViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var regMailTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var regPassTextField: UITextField!
    @IBOutlet weak var regConfirmPassTextField: UITextField!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        regMailTextField.delegate = self
        regPassTextField.delegate = self
        regConfirmPassTextField.delegate = self
        
        SetUpOutlets()
        notifications1()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            dismissKeyboard()
        }
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
    
    // MARK: - Actions
    @IBAction func registerButtonAction(_ sender: Any) {
        dismissKeyboard()
    }
    
}
