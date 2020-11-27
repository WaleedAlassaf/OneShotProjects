//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Waleed Alassaf on 27/11/2020.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoID: String?
    @NSManaged public var title: String?
    @NSManaged public var dateTaken: Date?
    @NSManaged public var remoteURL: URL?

}

extension Photo : Identifiable {

}
