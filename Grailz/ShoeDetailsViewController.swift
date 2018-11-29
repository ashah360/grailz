//
//  ShoeDetailsViewController.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class ShoeDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblShoeName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblVideoReviews: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVideoReviews.dequeueReusableCell(withIdentifier: "Video") as! VideoReviewsTableViewCell
//        cell.lblVideo.text = "Video 1"
        return cell
    }
    
    
    var appData = Data.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPic.image = UIImage(named: appData.shoes[appData.row]!["img"]!)
        lblShoeName.text = appData.shoes[appData.row]!["name"]
        lblReleaseDate.text = appData.shoes[appData.row]!["date"]
        lblDescription.text = appData.shoes[appData.row]!["description"]
    }
}
