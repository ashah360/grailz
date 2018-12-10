//
//  Data.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class ShoesData: NSObject {
    
    static let shared = ShoesData()

    open var shoes: [Int: [String: String]] = [
        0: [
            "img": "bred4s.jpeg",
            "name": "(0) Air Jordan Bred 4",
            "date": "xx/xx/xx",
        ],
        1: [
            "img": "bred4s.jpeg",
            "name": "(1) Air Jordan Bred 4",
            "date": "xx/xx/xx",
        ]
    ]
    
    open var title = ""
    open var release = ""
    open var imgUrl: Data = Data()
    
    open var row = 0
    
}
