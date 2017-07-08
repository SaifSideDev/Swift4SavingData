//
//  Person+CoreDataProperties.swift
//  Swift4SavingData
//
//  Created by Saif Khan on 7/7/17.
//  Copyright © 2017 SaifSide Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
