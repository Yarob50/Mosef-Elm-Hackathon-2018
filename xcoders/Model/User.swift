//
//  User.swift
//  xcoders
//
//  Created by Ammar AlTahhan on 07/04/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation

struct User {
    var userId: String?
    var fullName: String?
    var mobile: String?
    var email: String?
    var imageUrl: String?
    
    init(_ id: String, _ fullName: String, _ mobile: String, _ email: String = "", imageUrl: String = "") {
        self.userId = id
        self.fullName = fullName
        self.mobile = mobile
        self.email = email
        self.imageUrl = imageUrl
    }
}
