//
//  User.swift
//  1Million
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import Foundation

class User {
    var id: Int
    var name: String
    var mobile: String
    var national_id : String
    var email : String
    var city : String
    var token: String
    
    init(id: Int, name: String, mobile: String, token: String, national_id: String, email: String, city: String) {
        self.id = id
        self.name = name
        self.mobile = mobile
        self.national_id = national_id
        self.email = email
        self.token = token
        self.city = city
    }
} 
