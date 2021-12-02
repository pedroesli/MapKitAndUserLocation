//
//  CoreDataManager.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 30/11/21.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    private init(){ }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MapKitAndUserLocation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllCDAnnotations() -> [CDAnnotation] {
        let holder = fetchHolder()
        return holder?.annotations?.array as? [CDAnnotation] ?? []
    }
    
    //@discardableResult
    func createCDAnnotation(latitude: Double, longitude: Double, title: String, notes: String, address: String) -> CDAnnotation {
        var holder = fetchHolder()
        if holder == nil {
            holder = CDHolder(context: context)
        }
        
        let newCDAnnotation = CDAnnotation(context: context)
        newCDAnnotation.latitude = latitude
        newCDAnnotation.longitude = longitude
        newCDAnnotation.title = title
        newCDAnnotation.notes = notes
        newCDAnnotation.address = address
        
        holder?.insertIntoAnnotations(newCDAnnotation, at: 0)
        saveContext()
        return newCDAnnotation
    }
    
    func deleteCDAnnotation(cdAnnotation: CDAnnotation){
        context.delete(cdAnnotation)
        saveContext()
    }
    
    private func fetchHolder() -> CDHolder? {
        do{
            return try context.fetch(CDHolder.fetchRequest()).first
        }
        catch{
            print("Fetch holder error: \(error)")
            return nil
        }
    }
    
}
