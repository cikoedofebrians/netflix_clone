//
//  APICaller.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 23/06/23.
//

import Foundation


enum APIError: Error {
    case failedToGetData
}


enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class APICaller {
    static let shared = APICaller()
    
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.failedToGetData))
                return
            }
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/trending/movie/day?api_key=\(Constant.tmdbAPIKey)") else {return}
        fetchData(from: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                completion(.success(titles.results))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/trending/tv/day?api_key=\(Constant.tmdbAPIKey)") else {return}
        fetchData(from: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                completion(.success(titles.results))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/popular?api_key=\(Constant.tmdbAPIKey)") else {return}
        fetchData(from: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                completion(.success(titles.results))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/top_rated?api_key=\(Constant.tmdbAPIKey)") else {return}
        fetchData(from: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                completion(.success(titles.results))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/upcoming?api_key=\(Constant.tmdbAPIKey)") else {return}
        fetchData(from: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                completion(.success(titles.results))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/discover/movie?api_key=\(Constant.tmdbAPIKey)") else {return}
        fetchData(from: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                completion(.success(titles.results))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    public func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constant.baseUrl)/3/search/movie?api_key=\(Constant.tmdbAPIKey)&query=\(query)") else {return}
        
        fetchData(from: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                completion(.success(titles.results))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    
    func getMovie(with query: String, completion: @escaping (Result<YoutubeItem, Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constant.youtubeBaseUrl)q=\(query)&key=\(Constant.youtubeAPIKey)") else {return}
        fetchData(from: url) { (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let searchResponses):
                completion(.success(searchResponses.items[0]))
            case .failure(_):
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
}
