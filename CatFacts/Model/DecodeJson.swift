//
//  JsonDecode.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import Foundation

class DecodeJson {
    
    static let shared = DecodeJson()
    var cats: Cats?
    
    func decodeJson() {
            let jsonUrlString = "https://cat-fact.herokuapp.com/facts"
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    self.cats = try? JSONDecoder().decode(Cats.self, from: data)
                    //print(self.cats!)
                }
            }.resume()
    }
}

