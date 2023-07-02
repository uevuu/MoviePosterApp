//
//  FilmEntity+CoreDataProperties.swift
//  
//
//  Created by Nikita Marin on 02.07.2023.
//
//

import Foundation
import CoreData

extension FilmEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<FilmEntity> {
        return NSFetchRequest<FilmEntity>(entityName: "FilmEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var nameRu: String?
    @NSManaged public var coverUrl: String?
    @NSManaged public var year: Int64
    @NSManaged public var filmLength: Int64
    @NSManaged public var filmDescription: String?
    @NSManaged public var ratingImdb: Double
    @NSManaged public var posterUrl: String
    @NSManaged public var posterUrlPreview: String
    @NSManaged public var isTicketsAvailable: Bool
}
