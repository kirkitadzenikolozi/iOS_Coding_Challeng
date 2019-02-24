//
//  APIService.swift
//  iOS_Coding_Challenge
//
//  Created by Nika Kirkitadze on 2/23/19.
//  Copyright © 2019 organization. All rights reserved.
//

import Foundation
import ProgressHUD

class APIService {
    
    internal let BASE_URL = "https://rss.itunes.apple.com/api/v1/"
    
    enum Method: String {
        case appleMusic         = "us/apple-music/hot-tracks/all/25/explicit.json"
        case itunesMusic        = "us/itunes-music/hot-tracks/all/25/explicit.json"
        case iosApps            = "us/ios-apps/top-free/all/25/explicit.json"
        case macApps            = "us/macos-apps/top-free-mac-apps/all/25/explicit.json"
        case audioBooks         = "us/audiobooks/top-audiobooks/all/25/explicit.json"
        case books              = "us/books/top-free/all/25/explicit.json"
        case tvShows            = "us/tv-shows/top-tv-episodes/all/25/explicit.json"
    }
    
    enum HTTPMethod: String {
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
    
    func fetchFeed(method: Method, success:((_:FeedModel) -> Void)?,
                      fail:((_ message:String)-> Void)? = nil) {
        ProgressHUD.show()
        let request = NSMutableURLRequest(url: NSURL(string: BASE_URL + method.rawValue)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                fail!(error.debugDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if let httpStatus = httpResponse, httpStatus.statusCode == 200 {
                    
                    guard let dataResponse = data else {
                        print("Error: No data to decode")
                        return
                    }
                    
                    guard let feed = try? JSONDecoder().decode(FeedModel.self, from: dataResponse) else {
                        print("Error: Couldn't decode data into Feed")
                        return
                    }
                    
                    success!(feed)
                }
            }
            
            ProgressHUD.dismiss()
        })
        
        dataTask.resume()
    }
}
