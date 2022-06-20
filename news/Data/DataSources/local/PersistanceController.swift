//
//  PersistanceController.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation
import CoreData

struct PerisistanceController {
    
    static let shared = PerisistanceController()
    
    let container:NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Cache")
        container.loadPersistentStores { descriprion, error in
            if let error = error {
                fatalError("Core Data Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping(Error?)->() = {_ in}){
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            }catch{
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping(Error?)->() = {_ in}){
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
        
    }
    
    func saveArticle(_ article:ArticleDTO){
        let context = container.viewContext
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "ArticleEntity", into: context) as! ArticleEntity
        newItem.content = article.content
        newItem.urlToImage = article.urlToImage
        newItem.title = article.title
        newItem.url = article.url
        save()
    }
    
    
    func fetchArticles() async throws -> [ArticleDTO]{
        let context = container.viewContext
        let fr:NSFetchRequest<ArticleEntity>=ArticleEntity.fetchRequest()
        do {
           let searchResults = try context.fetch(fr)
            var news:[ArticleDTO] = []
            let fetchedNews = searchResults.map { entity in
                return ArticleDTO(entity: entity)
            }
            news.append(contentsOf: fetchedNews)
            return fetchedNews
        } catch {
            print("error \(error.localizedDescription)")
            throw error
        }

        
    }
    
    
    
}
