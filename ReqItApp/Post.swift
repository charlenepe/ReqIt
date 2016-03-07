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
    private var _postDescription: String!
    private var _imgURL: String?
    private var _bids: Int!
    private var _username: String!
    private var _postkey: String!
    private var _title: String!
    
    var postDescription: String! {
        return _postDescription
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
    
    
    var username: String! {
        return _username
    }
    
    var postKey: String! {
        return _postkey
    }
    
    init(description: String!, imgURL: String?, bids: Int!, username: String, title: String!){
        self._postDescription = postDescription
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
        
        if let imgURL = dictionary["imgURL"] as? String {
            self._imgURL = imgURL
        }
        
        if let desc = dictionary["description"] as? String {
            self._postDescription = desc
        }
        
        if let title = dictionary["title"] as? String {
            self._title = title
        }
        
        if let username = dictionary["username"] as? String {
            self._username = username }
    }
    
    
}