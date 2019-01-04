//
//  TableViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var navBarItemOutlet: UINavigationItem!
    @IBOutlet weak var logoutButtonOutlet: UIBarButtonItem!
    
    let identifire = "customCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
    
    }
   
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DecodeJson.shared.cats?.all.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        cell.textLabel?.text = DecodeJson.shared.cats?.all[indexPath.row].user?.name.first
        cell.detailTextLabel?.text = DecodeJson.shared.cats?.all[indexPath.row].text
        
        return cell
    }
    
}
