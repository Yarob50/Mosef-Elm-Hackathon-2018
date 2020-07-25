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

class PostRequest
{
    
    
    
    class func addPost(with params: [String: Any], headers: [String: String], completion: @escaping (_ error: Error?, _ postId: String?)->Void) {
        let url = URL(string: Url.baseUrl+Url.postsUrl)!
        Alamofire.request(url, method: .post, parameters: params, headers: headers).validate(statusCode: 200..<600).responseJSON { (response) in
            switch response.result {
            case .success(let val):
                let json = JSON(val)
                let postId = json["post_id"].stringValue
                completion(nil, postId)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    class func addPost(with params: [String: Any], headers: [String: String], image: UIImage, completion: @escaping (_ error: Error?)->Void) {
        addPost(with: params, headers: headers) { (err, postId) in
            
            guard let id = postId else { return }
            guard let token = defaults.string(forKey: "token") else { completion(NSError()); return }
            print("id")
            let url = URL(string: "\(Url.baseUrl)\(Url.postsUrl)/\(id)")!
            print(url)
            let headers: [String: String ] = [
                "Authorization": "bearer 8dd766e8360a959695fef66fe53489d3ed6fd971aa97e004d6748e15554646b5",
                "Content-Type": "image/jpg"
            ]
            
            //let image = UIImage.init(named: "myImage")
            let imgData = UIImageJPEGRepresentation(image, 0.2)!
            
            let parameters = ["name": "test"] //Optional for extra parameter
            
            Alamofire.upload(multipartFormData:{ multipartFormData in
                multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                } },
                             usingThreshold:UInt64.init(),
                             to:url.absoluteString,
                             method:.put,
                             headers:headers,
                             encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.responseJSON { response in
                                        debugPrint(response)
                                    }
                                case .failure(let encodingError):
                                    print(encodingError)
                                }
            })
            
            
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                } //Optional for extra parameters
//            }, usingThreshold: UInt64.init(), to:url.absoluteString, method: .put, headers: headers
//                             )
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//
//                    upload.responseJSON { response in
//                        print(response.result.value)
//                    }
//
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }

            
            
            
            
            
//            if let data = UIImageJPEGRepresentation(image, 1) {
//                Alamofire.upload(multipartFormData: { (multipartFormData) in
//                    multipartFormData.append(data, withName: "random", fileName: "Any",mimeType: "image/jpeg")
//                }, usingThreshold: UInt64.init(), to: url, method: .put, headers: headers, encodingCompletion: nil)
//            }
//            let imgData = UIImageJPEGRepresentation(image, 0.8)!
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpeg", mimeType: "image/jpeg")
//            }, to:"mysite/upload.php") { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//                    upload.responseJSON { response in
//                        print(response.result.value)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }
//            var request = URLRequest(url: url)
//            request.httpMethod = "PUT"
//
//            var boundary: String = generateBoundaryString()
//            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//            var body = NSMutableData()
//            var imageData = UIImagePNGRepresentation(image)
//
//            if imageData != nil {
//
//                body.append("--\(boundary)\r\n".data(using: .utf8)!)
//                body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
//                body.append("Content-Type: image/png".data(using: .utf8)!)
//                body.append(imageData!)
//                body.append("\r\n".data(using: .utf8)!)
//
//
//            }
//
//
//
//            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//            request.setValue("\(body.length)", forHTTPHeaderField:"Content-Length")
//            request.httpBody = body.copy() as! Data
//
//            request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
//            request.setValue("image/png", forHTTPHeaderField: "Content-Type")
//
//            Alamofire.request(request).responseJSON(completionHandler: { (response) in
//                switch response.result {
//                case .success(let val):
//                    print("Image posted successfully")
//                case .failure(let error):
//                    print("Error posting image \(error)")
//                    completion(error)
//                }
//
//            })
            
        }
        
    
        
    }
    
    class func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    class func getPosts(latitude: String, longitude: String, radius: Int, completion: @escaping (_ error: Error?, _ posts: [Post]?)->Void) {
        let url = URL(string: "\(Url.baseUrl)\(Url.postsUrl)\(Url.getPostParams)&longitude=\(longitude)&latitude=\(latitude)&radius_km=\(radius)")!
        print(url)
        guard let token = defaults.string(forKey: "token") else { completion(NSError(), nil); return }
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept-Language": "ar",
            "Authorization": "bearer \(token)"
        ]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<400).responseJSON { (response) in
            switch response.result {
            case .success(let val):
                let json = JSON(val)
                var posts: [Post] = []
                for post in json {
                    let user = post.1["user"]
                    let userObject = User.init(user["user_id"].stringValue, user["full_name"].stringValue, user["mobile"].stringValue, user["email"].stringValue, imageUrl: user["url"].stringValue)
                    let postObject = Post.init(userObject, String(post.1["longitude"].doubleValue), String(post.1["latitude"].doubleValue), post.1["post_image"].stringValue, post.1["metadata"]["criticality"].intValue, post.1["metadata"]["status"].intValue, lastUpdate: post.1["updated_at"].stringValue.apiDateFormattingTime.shortTimeFormatting)
                    posts.append(postObject)
                }
                completion(nil, posts)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    //the best code for the request : 
    class func request(url : String, callback : @escaping (_ post:[Post])->Void)
    {
        let url = URL(string:url)
        Alamofire.request(url!).responseJSON { (response) in
            switch response.result
            {
            case .success(let val):
                let json = JSON(val)
                let data = json["data"]
                print(data," is the data :)")
                var posts = [Post]()
                for row in json
                {
//                    var post = Post()
//                    let title = row.1["title"].stringValue
//                    post.title = title
//                    posts.append(post)
                }
                callback(posts)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    class func requestWithErrorHandling(url : String)
    {
        //in alamofire success means almost nothing without using validate function before the response and that's because .success will occur when the connection works fine with the server even if the server returns 400 code
        let url = URL(string:url)
        Alamofire.request(url!)
            .validate(statusCode: 200..<300)//should be only 201 for post requests, because the server returns 200 sometimes when the object is already exist so it won't post a new one
            .responseJSON { (response) in
                switch response.result
                {
                case .success:
                    print("succes!!")
                case .failure(let e):
                    print("failed :(")
                    
                }
                if let result = response.data
                {
                    print(result)
                    
//                    do
//                    {
//                        self.posts = try JSONDecoder().decode([Post].self,from:result)
//                        for post in self.posts
//                        {
//                            print(post.title,":",post.body,":",post.id,":",post.userId)
//                        }
//                    }catch
//                    {
//
//                    }
                }else{
                    print("error occured")
                }
        }
    }
    
    class func post(url : String, params : [String:String])
    {
        let url = URL(string:url)
        Alamofire.request(url!, method: HTTPMethod.post, parameters: params,encoding:JSONEncoding.default).responseJSON
            {
                (response) in
                switch response.result
                {
                case .success(let s):
                    print("succes with : ",s)
                case .failure(let e):
                    print("failed :( with ", e)
                    
                }
                
                if let data = response.data
                {
                    print("the data is " , data)
                }else{
                    print("there is no data ")
                }
        }
    }
    
    
    //if you want to use headers in the request :
    func postInWithHeaders(url : String, params : [String:String])
    {
        //the header :
        let headers = ["Content-type":"application/json"]
        
        
        let url = URL(string:url)
        Alamofire.request(url!, method: HTTPMethod.post, parameters: params,encoding:JSONEncoding.default,headers:headers).responseJSON
            {
                (response) in
                switch response.result
                {
                case .success(let s):
                    print("succes with : ",s)
                case .failure(let e):
                    print("failed :( with ", e)
                    
                }
                
                if let data = response.data
                {
                    print("the data is " , data)
                }else{
                    print("there is no data ")
                }
        }
    }
    
    func authRequest(url : String)
    {
        var headers : HTTPHeaders = ["Content-type" : "application/json"]
        let user = "user"
        let password = "12345"
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password)
        {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        let url = URL(string:url)
        Alamofire.request(url!,headers:headers).validate().responseJSON { (response) in
            switch response.result
            {
            case .success:
                print("ok")
            case .failure(let e):
                print("failure with",e)
                
            }
        }
        
        //some times you can use Alamofire.authenticate() method but it doesn't alway work
    }
}



extension Url {
    fileprivate static let postsUrl = "/posts"
    fileprivate static let getPostParams = "?metadata_key=IncidentCriticality"
}
