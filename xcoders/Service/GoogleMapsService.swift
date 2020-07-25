//
//  GoogleMaps.swift
//  xcoders
//
//  Created by Ammar AlTahhan on 06/04/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GoogleMaps {
    
    static let GMKey = "AIzaSyAoO0CtE545ELTJVKDglCh31N9dZizfVM4"
    
    class func getLocation(with latitude: String, longitude: String, completion: @escaping (_ location: String)->Void) {
        let addressURL: String = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(GMKey)"
        Alamofire.request(URL(string: addressURL)!).responseJSON(completionHandler: {(result) in
            if let json = result.result.value {
                let obj = JSON(json)
                let text1 = obj["results"][0]["formatted_address"].stringValue
                print(text1)
                completion(text1)
            }
        })
    }
    
}
