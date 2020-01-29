//
//  RequestManager.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 28/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static func upload(endUrl: String, imagedata: Data?, parameters: [String : String], completion: @escaping ( _ response: Bool) -> Void){
 
        let url = endUrl

        let headers: HTTPHeaders = [

            "Content-type": "multipart/form-data"
        ]

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }

            if let data = imagedata{
                multipartFormData.append(data, withName: "imagename", fileName: "imagename.jpg", mimeType: "image/jpeg")
            }

        }, to:url,headers: headers)
        { (result) in
            switch result{
            case .success(let upload, _ , _):
                upload.responseJSON { response in
                    
                    completion(true)

                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                    completion(false)

            }
        }        
    }
    
    static func login(parameters: [String : String], completion: @escaping ( _ response: Bool) -> Void){
        
        Alamofire.request("http://albertolourenco.com.br/cloudwork/?action=login",
                          method: .post,
                          parameters: parameters,
                          headers: nil).responseJSON { response in
        
                          switch response.result {
                              case .success:
                          
                                  if let jsonData = response.data {
                                      
                                      do {
                                          let apiAnswer = try JSONDecoder.init().decode(APIResponse.self, from: jsonData)
                                          
                                          if apiAnswer.result == true {
                                            completion(true)
                                              
                                              Util.showMessage(text: apiAnswer.message, type: .success)
                                          }else{
                                            completion(false)
                                              Util.showMessage(text: apiAnswer.message, type: .warning)
                                          }
                                          
                                      } catch {
                                        completion(false)
                                          print(error)
                                          
                                      }
                                  }

                                  break
                              case .failure:
                                completion(false)
                                  break
                          }
                      }
        
    }
    
    static func getPosts(completion: @escaping ( _ response: Array<Post>) -> Void){
    
        Alamofire.request("http://albertolourenco.com.br/cloudwork/?action=posts",
                          method: .get,
                          headers: nil).responseJSON { response in
                            
                            switch response.result {
                            case.success:
                                
                                if let jsonData = response.data {
                                    
                                    do {
                                        
                                        let apiAnswer = try JSONDecoder.init().decode([Post].self, from: jsonData)
                                        
                                        completion(apiAnswer)
                                    } catch{
                                        completion([])
                                    }
                                    
                                }
                                break
                            case.failure:
                                completion([])
                                break
                            }
        }
    }
    
    static func getPost(postId: Int, parameters: [String : String], completion: @escaping ( _ response: Post?) -> Void){
        
            Alamofire.request("http://albertolourenco.com.br/cloudwork/?action=postDetail&post_id=\(postId)",
                              method: .get,
                              parameters: parameters,
                              headers: nil).responseJSON { response in
                                
                                switch response.result {
                                case.success:
                                    
                                    if let jsonData = response.data {
                                        
                                        do {
                                            
                                            let apiAnswer = try JSONDecoder.init().decode(Post?.self, from: jsonData)
                                            
                                            completion(apiAnswer)
                                        } catch{
                                            completion(nil)
                                        }
                                        
                                    }
                                    break
                                case.failure:
                                    completion(nil)
                                    break
                                }
            }
    }
    
}


