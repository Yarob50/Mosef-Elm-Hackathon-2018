//
//  APNService.swift
//  xcoders
//
//  Created by Ammar AlTahhan on 07/04/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation
import Alamofire

class APNService {
    
    class func addToken(_ deviceToken: String, completion: @escaping (_ err: Error?)->Void) {
        let url = Url.baseUrl+Url.updateToken
        guard let token = defaults.string(forKey: "token") else { completion(NSError()); return }
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept-Language": "ar",
            "Authorization": "bearer \(token)"
        ]
        let params: [String: String] = [
            "device_token": deviceToken,
            "token_type": "IOS"
        ]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<600).responseJSON { (response) in
            switch response.result
            {
            case .success:
                print("Device Token Uploaded")
                completion(nil)
            case .failure(let e):
                completion(e)
                
            }
        }
    }
    
}

extension Url {
    fileprivate static let updateToken = "/device_tokens"
}
