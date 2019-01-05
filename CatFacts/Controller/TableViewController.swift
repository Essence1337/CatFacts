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
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        tableViewOutlet.estimatedRowHeight = 68.0
        tableViewOutlet.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonAction(_ sender: Any) {
        
    }
    
}

// MARK: - Extensions
extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DecodeJson.shared.cats?.all.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        
        if  let firstName = DecodeJson.shared.cats?.all[indexPath.row].user?.name.first {
            first = firstName
        }
        
        if let lastName = DecodeJson.shared.cats?.all[indexPath.row].user?.name.last {
            last = lastName
        }
        
        cell.textLabel?.text = "\(first) \(last)"
        cell.detailTextLabel?.text = DecodeJson.shared.cats?.all[indexPath.row].text
        
        return cell
    }
    
}
