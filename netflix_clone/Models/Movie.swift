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
func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
    guard let url = URL(string: "\(Constant.baseUrl)/movie/top_rated?api_key=\(Constant.tmdbAPIKey)") else {return}
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else{
            return
        }
        do {
            let results = try JSONDecoder().decode(TitleResponse.self, from: data)
            completion(.success(results.results))
        }catch {
            completion(.failure(error))
        }
    }
    task.resume()
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


