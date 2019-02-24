//
//  FeedTracks.swift
//  iOS_Coding_Challenge
//
//  Created by Nika Kirkitadze on 2/23/19.
//  Copyright © 2019 organization. All rights reserved.
//

import Foundation

struct FeedModel: Codable {
    
    let feed: Feed?
    
    struct Feed: Codable {
        let title: String?
        let id: String?
        let author: Author?
        let links: [Link]?
        let copyright: String?
        let country: String?
        let icon: String?
        let updated: String?
        let results: [Result]?
        
        struct Author: Codable {
            let name: String?
            let uri: String?
        }
        
        struct Link: Codable {
            let linkSelf: String?
            let alternate: String?
            
            enum CodingKeys: String, CodingKey {
                case linkSelf = "self"
                case alternate
            }
        }
        
        struct Result: Codable {
            let artistName: String?
            let id: String?
            let releaseDate: String?
            let name: String?
            let kind: String?
            let copyright: String?
            let artistID: String?
            let artistURL: String?
            let artworkUrl100: String?
            let genres: [Genre]?
            let url: String?
            let contentAdvisoryRating: String?
            
            struct Genre: Codable {
                let genreID: String?
                let name: String?
                let url: String?
                
                enum CodingKeys: String, CodingKey {
                    case genreID = "genreId"
                    case name, url
                }
            }
            
            enum CodingKeys: String, CodingKey {
                case artistName, id, releaseDate, name, kind, copyright
                case artistID = "artistId"
                case artistURL = "artistUrl"
                case artworkUrl100, genres, url, contentAdvisoryRating
            }
        }
    }
}
