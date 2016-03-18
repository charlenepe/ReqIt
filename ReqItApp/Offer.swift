//
//  Post.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/3/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation
import Firebase

class Offer {
    
    private var _offerKey: String!
    private var _title: String!
    private var _description: String!
    private var _imgURL: String?
    private var _accepted: Bool!
    private var _username: String!
    private var _postkey: String!
    private var _createdAt: Double!
    
    var title: String! { return _title }
    var description: String! { return _description }
    var imgURL: String? { return _imgURL }
    var accepted: Bool! { return _accepted }
    var username: String! { return _username }
    var postKey: String! { return _postkey }
    var createdAt: Double { return _createdAt}
    
    
    init(description: String!, imgURL: String?, bids: Int!, username: String, title: String!, postKey: String!, accepted: Bool!){
        self._title = title
        self._description = description
        self._imgURL = imgURL
        self._username = username
        self._postkey = postKey
        self._accepted = accepted
    }
    
    init(offerKey: String, dictionary: Dictionary<String, AnyObject>){
        self._offerKey = offerKey
        
        if let title = dictionary["title"] as? String {
            self._title = title
        }
        
        if let desc = dictionary["description"] as? String {
            self._description = desc
        }
        
        if let imgURL = dictionary["imgURL"] as? String {
            self._imgURL = imgURL
        }
        
        if let accepted = dictionary["accepted"] as? Bool {
            self._accepted = accepted
        }
        
        if let username = dictionary["username"] as? String {
            self._username = username
        }
        
        if let postKey = dictionary["postKey"] as? String {
            self._postkey = postKey
        }
    
        if let createdAt = dictionary["createdAt"] as? Double {
            self._createdAt = createdAt
        }
    }
    
}