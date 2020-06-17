//
//  Nocatuser.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 17/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import Foundation
import CoreData

class Nocatuser: NSManagedObject {
    @NSManaged var deviceId: String
    @NSManaged var userName: String
    
    static var entityName: String { return "Nocatuser" }
}
