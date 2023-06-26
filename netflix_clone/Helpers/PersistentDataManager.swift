//
//  PersistentDataManager.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 26/06/23.
//

import Foundation
import UIKit
import CoreData


enum CoreDataError: Error {
    case failedToSaveData
    case failedToFetchData
}

class PersistentDataManager{
    static let shared = PersistentDataManager()
    
    func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func saveTitle(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let context = getContext() else {return}
        let title = Titles(context: context)
        
        title.id = Int64(model.id)
        title.media_type = model.media_type
        title.original_name = model.original_name
        title.original_title = model.original_title
        title.overview = model.overview
        title.poster_path = model.poster_path
        title.release_date = model.release_date
        title.vote_count = Int64(model.vote_count)
        title.vote_average = model.vote_average
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
                completion(.failure(CoreDataError.failedToSaveData))
        }
    }
    
    func fetchTitles(completion: @escaping(Result<[Titles], Error>) -> Void){
        guard let context = getContext() else {return}
        let request: NSFetchRequest<Titles> = Titles.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch {
            completion(.failure(CoreDataError.failedToFetchData))
        }
    }
    
    func deleteTitle(model: Titles ,completion: @escaping(Result<Void, Error>) -> Void){
        guard let context = getContext() else {return}        
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(CoreDataError.failedToFetchData))
        }
    }
}
