//
//  Offer.swift
//  ReqItApp
//
//  Created by Charlene Pe on 3/8/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation


class Offer {
   var bidDescription: String!
   var username: String!
   var bidkey: String!
   var title: String!
    

    init(bidKey: String!, title: String!, bidDescription: String!) {
        self.bidDescription = bidDescription
        self.bidkey = bidKey
        self.title = title
    }

    
    
}