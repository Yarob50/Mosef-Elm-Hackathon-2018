//
//  Post.swift
//  Practice
//
//  Created by يعرب المصطفى on 4/4/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import UIKit

struct Post
{
    var user:User!
    var longitude: String!
    var latitude: String!
    var imageUrl:String?
    var criticality: Int?
    var color: UIColor?
    var status: Int?
    var lastUpdate: String?
    
    init(_ user: User, _ longitude: String, _ latitude: String, _ imageUrl: String, _ criticality: Int, _ status: Int, lastUpdate: String) {
        self.user = user
        self.longitude = longitude
        self.latitude = latitude
        self.imageUrl = imageUrl
        self.status = status
        self.lastUpdate = lastUpdate
        self.criticality = criticality
        switch criticality {
        case 1:
            color = Color.colors[2]
        case 2:
            color = Color.colors[1]
        default:
            color = Color.colors[0]
        }
    }
    
}
