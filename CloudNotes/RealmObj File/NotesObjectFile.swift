//
//  ObjectFile.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 31/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import Foundation
import RealmSwift

class Notes:Object{
    @objc dynamic var _Notes:String? = nil
    override static func primaryKey() -> String? {
        return "_Notes"
    }
    
    
}

extension Notes {
        func writeRealm() {
            try! uiRealm.write {
                uiRealm.add(self, update: true)
            }
        }
 
    
    }
    

