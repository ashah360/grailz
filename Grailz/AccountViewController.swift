//
//  SecondViewController.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    var user : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (user == nil) {
            performSegue(withIdentifier: "toLogin", sender: self)
        }
    }

}

