

import Foundation
import CoreData
/*


extension CodingUserInfoKey {
    static let context: CodingUserInfoKey = CodingUserInfoKey(rawValue: "NSManagedObjectContext")!
}

class CoreDataService {
    
  
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
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
    
}

/// all Favorite-related stuff here
extension CoreDataService {
    /*
    func createTrainer(_ image: Data, _ name: String,
                       _ completion: @escaping (Trainer)->Void) {
        persistentContainer.performBackgroundTask { (context) in
            let trainer = NSEntityDescription.insertNewObject(forEntityName: "Trainer",
                                                              into: context) as! Trainer
            
            trainer.name = name
            trainer.image = NSData(data: image)
            
            try! context.save()
            completion(trainer)
        }
    }
    
    func checkIfTrainerExists() -> Bool {
        // let fetch = NSFetchRequest<Trainer>(entityName: "Trainer")
        let fetch: NSFetchRequest = Trainer.fetchRequest()
        do {
            let results = try context.fetch(fetch)
            return results.count > 0
        }
        catch {}
        return false
    }
    
    func loadTrainer() -> Trainer? {
        let fetch: NSFetchRequest = Trainer.fetchRequest()
        do {
            let results = try context.fetch(fetch)
            return results.first
        }
        catch {}
        return nil
    }
 */
}

extension CoreDataService {
    
    func printNumOfPokemon() -> Int {
        let fetch: NSFetchRequest = Pokemon.fetchRequest()
        do {
            let results = try context.fetch(fetch)
            return results.count
        }
        catch {}
        return 0
    }
    
    func deleteAllWildPokemon() {
        let fetch: NSFetchRequest = Pokemon.fetchRequest()
        do {
            let results = try context.fetch(fetch)
            for result in results {
                if result.trainer == nil {
                    context.delete(result)
                }
            }
            saveContext()
        }
        catch {}
    }
    
    func deleteTrainer() {
        let fetch: NSFetchRequest = Trainer.fetchRequest()
        do {
            let results = try context.fetch(fetch)
            for result in results {
                context.delete(result)
            }
            saveContext()
        }
        catch {}
    }
}
*/
