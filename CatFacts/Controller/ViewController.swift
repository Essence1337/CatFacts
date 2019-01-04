//
//  ViewController.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

struct Cats: Codable {
    struct All: Codable {
        struct User: Codable {
            struct Name: Codable {
                let first: String
                let last: String
            }
            let name: Name
        }
        let text: String
        let user: User?
    }
    let all:[All]
}

class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func myButton(_ sender: Any) {
        print(cats!.all[0].user!.name.first)
    }
    
    var cats: Cats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeJson()
        
        
        
    }
    
    func decodeJson() {
        DispatchQueue.global(qos: .userInteractive).async {
            
            let jsonUrlString = "https://cat-fact.herokuapp.com/facts"
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    self.cats = try? JSONDecoder().decode(Cats.self, from: data)
                    print(self.cats!)
                }
            }.resume()
        }
    }
    
}

