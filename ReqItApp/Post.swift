//
//  Post.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/3/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _description: String!
    private var _imgURL: String?
    private var _bids: Int!
    private var _pending: Int!
    private var _username: String!
    private var _postkey: String!
    private var _title: String!
    private var _createdAt: Double!
    private var _updatedAt: Double!
    
    var description: String! {
        return _description
    }
    
    var title: String! {
        return _title
    }
    
    var imgURL: String? {
        return _imgURL
    }
    
    var bids: Int! {
        return _bids
    }
    
    var pending: Int! {
        return _pending
    }
    
    var username: String! {
        return _username
    }
    
    var postKey: String! {
        return _postkey
    }
    
    var createdAt: Double! {
        return _createdAt
    }

    var updatedAt: Double! {
        return _updatedAt
    }
    
    init(description: String!, imgURL: String?, bids: Int!, username: String, title: String!){
        self._description = description
        self._imgURL = imgURL
        self._bids = bids
        self._username = username
        self._title = title
        
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>){
        self._postkey = postKey
        
        if let bids = dictionary["bids"] as? Int {
            self._bids = bids
        }
        
        if let pending = dictionary["pending"] as? Int {
            self._pending = pending
        }
        
        if let imgURL = dictionary["imgURL"] as? String {
            self._imgURL = imgURL
        }
        
        if let desc = dictionary["description"] as? String {
            self._description = desc
        }
        
        if let title = dictionary["title"] as? String {
            self._title = title
        }
        
        
        if let createdAt = dictionary["createdAt"] as? Double {
            self._createdAt = createdAt
        }
        
        if let updatedAt = dictionary["updatedAt"] as? Double {
            self._updatedAt = updatedAt
        }
        
        if let username = dictionary["username"] as? String {
            self._username = username }
    }
    
    func updateBids(addBids: Bool) {
        if addBids {
            _bids = _bids + 1
        } else {
            _bids = _bids - 1
        }
        
        DataService.ds.REF_POSTS.childByAppendingPath(_postkey).childByAppendingPath("bids").setValue(_bids)
    }
    
    func updatePending(addPending: Bool) {
        _pending = addPending ? _pending + 1 : _pending - 1
        
        DataService.ds.REF_POSTS.childByAppendingPath(_postkey).childByAppendingPath("pending").setValue(_pending)
    }
    
    func removeBid(offer: Offer) {
        if offer.accepted == true {
            self.updateBids(false)
        } else {
            self.updatePending(false)
        }
    }
    
    
}