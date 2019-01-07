//
//  InitialViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/7/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.checkAuthorize()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func checkAuthorize() {
        let def = UserDefaults.standard
        let is_authenticated = def.bool(forKey: "isLoggedIn")
        
        if is_authenticated {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.performSegue(withIdentifier: "fromInitialToTable", sender: self)
            }
        } else {
            performSegue(withIdentifier: "fromInitialToLogIn", sender: self)
        }
    }
    
}
