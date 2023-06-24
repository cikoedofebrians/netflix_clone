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
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/trending/movie/day?api_key=\(Constant.tmdbAPIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/trending/tv/day?api_key=\(Constant.tmdbAPIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/popular?api_key=\(Constant.tmdbAPIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/top_rated?api_key=\(Constant.tmdbAPIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constant.baseUrl)/3/movie/upcoming?api_key=\(Constant.tmdbAPIKey)") else {return}
        
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
    
}
