//
//  CoreDataStack.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 17/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import Foundation

import CoreData

func createMainContext(completion: @escaping (NSPersistentContainer) -> Void) {
    
    let container = NSPersistentContainer(name: "nocatModel")
    
    // Happens asynchronously!
    container.loadPersistentStores(completionHandler: {
        storeDescription, error in
        guard error == nil else {
            fatalError("Failed to load store: \(String(describing: error))")
        }
        
        
        DispatchQueue.main.async {
            completion(container)
        }
    })
}

protocol ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext! { get set}
}


