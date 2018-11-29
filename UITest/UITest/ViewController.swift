//
//  ViewController.swift
//  UITest
//
//  Created by Nathan Han on 11/27/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var lblShoeName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgPic: UIImageView!
    
    let shoeList: [Int: [String: String]] = [
                                                1: [
                                                    "img": "bred4s.jpeg",
                                                    "name": "Air Jordan Bred 4",
                                                    "date": "xx/xx/xx"
                                                    ]
                                            ]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoeList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

