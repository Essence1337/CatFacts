//
//  TableViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var navBarItemOutlet: UINavigationItem!
    @IBOutlet weak var logoutButtonOutlet: UIBarButtonItem!
    
    // MARK: - Properties
    let identifire = "customCell"
    var first: String = ""
    var last: String = ""
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        tableViewOutlet.estimatedRowHeight = 68.0
        tableViewOutlet.rowHeight = UITableView.automaticDimension
        
    }
    
    // Save authorize state.
    func saveLoggedState() {
        
        let def = UserDefaults.standard
        def.set(false, forKey: "isLoggedIn")
        def.synchronize()
        
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonAction(_ sender: Any) {
        saveLoggedState()
        performSegue(withIdentifier: "segueToLoginScreen", sender: self)
    }
    
}

// MARK: - Extensions
extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DecodeJson.shared.cats?.all.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        DispatchQueue.global(qos: .userInteractive).async {
        if  let firstName = DecodeJson.shared.cats?.all[indexPath.row].user?.name.first {
            self.first = firstName
        }
        
        if let lastName = DecodeJson.shared.cats?.all[indexPath.row].user?.name.last {
            self.last = lastName
        }
            DispatchQueue.main.async {
                cell.textLabel?.text = "\(self.first) \(self.last)"
                cell.detailTextLabel?.text = DecodeJson.shared.cats?.all[indexPath.row].text
            }
        }
        return cell
    }
    
}
