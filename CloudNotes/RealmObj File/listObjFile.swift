//
//  listObjFile.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 31/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import Foundation
import RealmSwift

class List:Object{
    @objc dynamic var _List:String? = nil
    override static func primaryKey() -> String? {
        return "_List"
    }
    
    
}

extension List {
    func writeRealm() {
        try! uiRealm.write {
            uiRealm.add(self, update: true)
        }
    }
}
