//
//  CoreDataService.swift
//  MyNotes2
//
//  Created by adyl CEO on 15/03/2024.
//
import UIKit
import CoreData
class CoreDataService {
    static let shared = CoreDataService()
    
    private init() {
        
    }
    
    private var appDelagate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelagate.persistentContainer.viewContext
    }
    
    func addNote(id: String, title: String, description: String, date: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        else { return }
        let note = Note(entity: entity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        
        appDelagate.saveContext()
    }
    
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest <NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    
 }
