//
//  Ctas.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/4/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import Foundation

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
