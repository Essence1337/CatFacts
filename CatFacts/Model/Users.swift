//
//  Users.swift
//  CatFacts
//
//  Created by Тимур Кошевой on 1/7/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import Foundation
import RealmSwift

class Users: Object {
    
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    
}
