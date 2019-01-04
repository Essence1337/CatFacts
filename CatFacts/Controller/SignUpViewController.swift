//
//  SignUpViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var confirmPassTextFieldOutlet: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextFieldOutlet.delegate = self
        passwordTextFieldOutlet.delegate = self
        confirmPassTextFieldOutlet.delegate = self
        SetUpOutlets()
    }

    func SetUpOutlets() {
        emailTextFieldOutlet.layer.cornerRadius = 5
        emailTextFieldOutlet.layer.borderWidth = 0.5
        emailTextFieldOutlet.layer.borderColor = UIColor.gray.cgColor
        
        passwordTextFieldOutlet.layer.cornerRadius = 5
        passwordTextFieldOutlet.layer.borderWidth = 0.5
        passwordTextFieldOutlet.layer.borderColor = UIColor.gray.cgColor
        passwordTextFieldOutlet.isSecureTextEntry = true
        
        confirmPassTextFieldOutlet.layer.cornerRadius = 5
        confirmPassTextFieldOutlet.layer.borderWidth = 0.5
        confirmPassTextFieldOutlet.layer.borderColor = UIColor.gray.cgColor
        confirmPassTextFieldOutlet.isSecureTextEntry = true

        
        registerButtonOutlet.layer.cornerRadius = 5
        registerButtonOutlet.layer.borderWidth = 0.5
        registerButtonOutlet.layer.borderColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func registerButtonAction(_ sender: Any) {
    }
    
}
