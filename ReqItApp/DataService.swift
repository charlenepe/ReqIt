//
//  DataService.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/2/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://reqit.firebaseio.com"
//let uid = reff.authData.uid

class DataService {
    static let ds = DataService()

    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
//    private var _REF_OFFERS = Firebase(url: "\(URL_BASE)/posts/*/offers")
    
//
//
//    private var _REF_INDIVPOSTS = Firebase(url: "\(URL_BASE)/users/\(uid!)/posts")
//    
    
    var REF_BASE: Firebase {
        return _REF_BASE
        
    }
//    
//    var REF_INDIVPOSTS: Firebase {
//        return _REF_INDIVPOSTS
//    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    func createFirebaseUser(uid: String, user: Dictionary <String, String>){
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
}
