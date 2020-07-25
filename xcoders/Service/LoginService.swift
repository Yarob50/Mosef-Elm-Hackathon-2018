//
//  PostRequest.swift
//  Practice
//
//  Created by يعرب المصطفى on 3/30/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginService
{
    
    //the best code for the request :
    class func login(phoneNumber : String, callback : @escaping (_ error:String?)->Void)
    {
        
        let stringUrl = Url.baseUrl + Url.loginUrl
        print("the url is \n\n")
        print(stringUrl)
        let url = URL(string:stringUrl)
        let params = ["mobile" : phoneNumber]
        
        Alamofire.request(url!,method: HTTPMethod.post, parameters: params)
            .validate(statusCode: 200..<600)
            .responseJSON { (response) in
                switch response.result
                {
                    case .success(let val):
                        let json = JSON(val)
                        print(json)
                        print("done with login  \n\n\n")
                        callback(nil)
//                        getCode(phoneNumber: phoneNumber, callback: {
//
//                        })
                    
                    
                    case .failure(let error):
                        print("there is an error : \n")
                        print(error)
                        callback(error.localizedDescription)
                }
        }
    }
    
    
    class func verifyCode(phoneNumber:String, code : String, callback : @escaping (_ error:String?, _ result:[String:String]?)->Void)
    {
        
        
        print("start verification")
        let stringUrl = Url.baseUrl + Url.verifySms
        print("the url is \n\n")
        print(stringUrl)
        let url = URL(string:stringUrl)
        let params:Parameters = ["mobile":phoneNumber,"code":code]
        
        let headers = ["Content-type":"application/json"]
        
        
        Alamofire.request(url!,method: HTTPMethod.post, parameters: params,encoding: JSONEncoding.default, headers:headers)
            .validate(statusCode: 200..<600)
            .responseJSON { (response) in
                switch response.result
                {
                case .success(let val):
                    
                    if let httpStatusCode = response.response?.statusCode
                    {
                       
                        switch httpStatusCode
                        {
                            case 400 :
                                callback("code is not correct", nil)
                                let json = JSON(val)
                                print(json)
                        default:
                            let json = JSON(val)
                            print(json)
                            print("done \n\n\n")
                            let token = json["access_token"].stringValue
                            let userId = json["user"]["user_id"].stringValue
                            callback(nil,["token":token,"userId":userId])
                        }
                        
                    }
                    
                    
                    
                case .failure(let error):
                    callback(error.localizedDescription, nil)
                }
        }
    }
    
    //to get the code as replacement to the login :
    class func getCode(phoneNumber : String, callback : @escaping ()->Void)
    {
        
        let stringUrl = Url.baseUrl + Url.getSms
        let url = URL(string:stringUrl)
        let params = ["mobile" : phoneNumber]
        
        Alamofire.request(url!,method: HTTPMethod.post, parameters: params)
            .validate(statusCode: 200..<600)
            .responseJSON { (response) in
                switch response.result
                {
                case .success(let val):
                    let json = JSON(val)
                    print(json.first!.1["code"])
                    //callback()
                    
                case .failure(let error):
                    print("there is an error : \n")
                    print(error)
                }
        }
    }
    
    
    
    
    
}
