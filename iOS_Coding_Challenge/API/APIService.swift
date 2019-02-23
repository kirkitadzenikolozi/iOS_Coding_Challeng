//
//  APIService.swift
//  iOS_Coding_Challenge
//
//  Created by Nika Kirkitadze on 2/23/19.
//  Copyright © 2019 organization. All rights reserved.
//

import Foundation

class APIService {
    
    internal let BASE_URL = "https://rss.itunes.apple.com/api/v1/"
    
    enum Method: String {
        case hotTracks      = "us/apple-music/hot-tracks/all/25/explicit.json"
        case topFreeApps    = "us/ios-apps/top-free/all/25/explicit.json"
    }
    
    enum httpMethod: String {
        case GET    = "GET"
        case POST   = "POST"
        case DELETE = "DELETE"
        case PUT    = "PUT"
    }
    
    let headers = ["content-type": "application/json"]
    
    class var shared : APIService {
        struct Singleton {
            static let instance = APIService()
        }
        return Singleton.instance
    }

    func fetchHotTracks(success:((_:FeedTracks) -> Void)?,
                        fail:((_ message:String)-> Void)? = nil) {
        let request = NSMutableURLRequest(url: NSURL(string: BASE_URL + Method.hotTracks.rawValue)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error.debugDescription)
                fail!(error.debugDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
}
