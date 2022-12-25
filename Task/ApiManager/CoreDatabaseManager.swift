//
//  CoreDatabaseManager.swift
//  InterviewTask
//
//  Created by Mavani on 12/10/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    func SaveData(data : ModelPhotos) -> Bool{
        
        let selectedPhotos = data
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Favorite",in: context!)!
        let product = NSManagedObject(entity: entity,insertInto: context)
        
        product.setValue("\(selectedPhotos.id)", forKey: "id")
        product.setValue(selectedPhotos.thumbnailUrl, forKey: "thumbnailUrl")
        product.setValue(selectedPhotos.title, forKey: "title")
        product.setValue(selectedPhotos.url, forKey: "url")
        product.setValue("\(selectedPhotos.albumId)", forKey: "albumId")
        do {
            try context?.save()
            return true
        } catch {
            return false
        }
    }
    
/*    func FetchFavorite(complation : @escaping ([Favorite]) -> ()) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        do {
            complation(try context.fetch(fetchRequest))
        } catch {
            print("Cannot fetch")
        }
    }
    
    
    func deletePhotos(data : Favorite) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        context?.delete(data)
        do {
            try  context?.save()
            return true
        } catch {
            return false
        }
    } */


}
