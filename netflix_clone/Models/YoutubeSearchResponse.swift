//
//  YoutubeSearchResponse.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 26/06/23.
//

import Foundation


// MARK: - YoutubeSearchResponse
struct YoutubeSearchResponse: Codable {
    let items: [YoutubeItem]
}

// MARK: - Item
struct YoutubeItem: Codable {
    let kind, etag: String
    let id: ID
}

// MARK: - ID
struct ID: Codable {
    let kind, videoId: String
}
