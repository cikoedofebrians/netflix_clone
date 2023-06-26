//
//  Movie.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 23/06/23.
//

import Foundation

struct TitleResponse : Codable {
    let results: [Title]
}

struct Title : Codable{
    let id: Int
    let original_name: String?
    let media_type: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}


