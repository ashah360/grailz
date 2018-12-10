//
//  Data.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

struct shoeElement {
    let index: Int
    let title: String
    let release: String
    let img: Data
    let imgUrl: String
    let _id: String
    let price: [String: String]
    var votes: [[String: String]]
}

class ShoesData: NSObject {
    
    static let shared = ShoesData()
    
    open var releaseList: [shoeElement] = []
    
    open var row = 0
    
    open var username: String? = nil
}
