//
//  DataService.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/2/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "https://reqit.firebaseio.com")
    
    var REF_BASE: Firebase {
        return _REF_BASE
        
    }
    
}
