//
//  FeedItem.swift
//  Index RSS
//
//  Created by Pap Csaba on 2019. 11. 03..
//  Copyright © 2019. Pap Csaba. All rights reserved.
//

import Foundation

class FeedItem {
    
    let title: String
    let description: String
    let link: String
    let img: String
    
    init(title: String, description: String, link: String, img: String) {
        self.title = title
        self.description = description
        self.link = link
        self.img = img
    }
}
