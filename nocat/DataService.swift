//
//  DataService.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 17/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import Foundation
import CoreData

struct DataService: ManagedObjectContextDependentType {
    
    var managedObjectContext: NSManagedObjectContext!

    func seedUsers() {
        let userFetchRequest = NSFetchRequest<Nocatuser>(entityName: Nocatuser.entityName)
        
        do {
            let usersAlreadySeeded = try self.managedObjectContext.fetch(userFetchRequest).count > 0

            if(usersAlreadySeeded == false) {

                let user1 = NSEntityDescription.insertNewObject(forEntityName: Nocatuser.entityName,
                                                                    into: self.managedObjectContext) as! Nocatuser
                user1.deviceId = "123"
                user1.userName = "pmanonu"
                
                let user2 = NSEntityDescription.insertNewObject(forEntityName: Nocatuser.entityName,
                                                                    into: self.managedObjectContext) as! Nocatuser
                user2.deviceId = "456"
                user2.userName = "Jack Baur"
                                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Something went wrong: \(error)")
                    self.managedObjectContext.rollback()
                }
            }
        } catch {}
        
        
    }
}
