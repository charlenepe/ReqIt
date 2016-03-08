//
//  Offer.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/8/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation


class Offer {
    private var _bidDescription: String!
    private var _imgURL: String?
    private var _username: String!
    private var _bidkey: String!
    private var _title: String!
    
    var description: String! {
        return _bidDescription
    }
    
    var title: String! {
        return _title
    }
    
    var imgURL: String? {
        return _imgURL
    }
    
    
    var username: String! {
        return _username
    }
    
    var bidKey: String! {
        return _bidkey
    }
    
    init(description: String!, imgURL: String?, username: String, title: String!){
        self._bidDescription = description
        self._imgURL = imgURL
        self._username = username
        self._title = title
        
    }
    
    init(bidKey: String, dictionary: Dictionary<String, AnyObject>){
        self._bidkey = bidKey
        
        
        if let imgURL = dictionary["imgURL"] as? String {
            self._imgURL = imgURL
        }
        
        if let desc = dictionary["description"] as? String {
            self._bidDescription = desc
        }
        
        if let title = dictionary["title"] as? String {
            self._title = title
        }
        
        if let username = dictionary["username"] as? String {
            self._username = username }
    }
    
    
}