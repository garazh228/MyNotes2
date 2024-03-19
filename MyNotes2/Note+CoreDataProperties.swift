//
//  Note+CoreDataProperties.swift
//  MyNotes2
//
//  Created by adyl CEO on 15/03/2024.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: String?

}

extension Note : Identifiable {

}
