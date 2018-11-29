//
//  FirstViewController.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class ReleasesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblReleases: UITableView!
    
    var appData = Data.shared
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.shoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(appData.shoes[indexPath.row]!["img"]!)
        let cell = tblReleases.dequeueReusableCell(withIdentifier: "Shoe") as! ShoeCellTableViewCell
        cell.imgPic.image = UIImage(named: appData.shoes[indexPath.row]!["img"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appData.row = indexPath.row
        performSegue(withIdentifier: "toShoeDetails", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(appData.shoes.count)
        appData.row = 0
        // Do any additional setup after loading the view, typically from a nib.
    }


}

