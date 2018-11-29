//
//  Data.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class Data: NSObject {
    
    static let shared = Data()

    open var shoes: [Int: [String: String]] = [
        0: [
            "img": "bred4s.jpeg",
            "name": "(0) Air Jordan Bred 4",
            "date": "xx/xx/xx",
            "description": "Details...",
        ],
        1: [
            "img": "bred4s.jpeg",
            "name": "(1) Air Jordan Bred 4",
            "date": "xx/xx/xx",
            "description": "Details...",
        ]
    ]
    
    open var row = 0
    
}
