//
//  Post.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/3/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation


class Post {
    var postDescription: String!
    var bids: Int!
    var username: String!
    var uuid: String!
    var title: String!
    
    init(postKey: String, postDescription: String!, uuid: String!, title: String! ){
        self.uuid = postKey
        self.postDescription = postDescription
        self.bids = 0
        self.title = title
  }
}

