//
//  FirstViewController.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

struct productList: Decodable {
    let created_at: String?
    let _id: String?
    let title: String?
    let active: Bool?
    let release: String?
    let images: [String: String]?
    let price: [String: String]?
    let votes: [[String: String]]?
    let _v: Int?
}

class ReleasesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblReleases: UITableView!
    
    
    var appData = ShoesData.shared
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appData.releaseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReleases.dequeueReusableCell(withIdentifier: "Shoe") as! ShoeCellTableViewCell
        cell.imgPic.image = UIImage(data: self.appData.releaseList[indexPath.row].img)
        cell.lblTitle.text = self.appData.releaseList[indexPath.row].title
        cell.lblRelease.text = self.appData.releaseList[indexPath.row].release
        
        date()
        
        return cell
    }
    
    func date() {
        let date = self.appData.releaseList[appData.row].release
        var month = date.firstIndex(of: "-")
//        switch month {
//        case month = "01-":
//            month = "January"
//        case month = "02-":
//            month = "February"
//        case month = "03-":
//            month = "March"
//        case month = "04-":
//            month = "April"
//        case month = "05-":
//            month = "May"
//        case month == "06-":
//            month = "June"
//        case month == "07-":
//            month = "July"
//        case month == "08-":
//            month = "August"
//        case month == "09-":
//            month = "September"
//        case month == "10-":
//            month = "October"
//        case month == "11-":
//            month = "November"
//        case month == "12-":
//            month = "December"
//        default:
//            month = "error"
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.appData.row = indexPath.row
        performSegue(withIdentifier: "toShoeDetails", sender: self)
    }
    
    func fetchJSON() {
        let base = "http://grailz.herokuapp.com/api/"
        guard let url =  URL(string: "\(base)product/list") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in DispatchQueue.main.async {
            guard let data = data else { return }
            do {
                let stringData = String(data: data, encoding: .utf8)
                print(stringData)
                let shoes =  try JSONDecoder().decode([productList].self, from: data)
                var index = 0
                for shoe in shoes {
                    
                    let images = shoe.images
                    var data: Data? = nil
                    
                    if let imgUrl = URL(string: (images?["product"])!) {
                        do {
                            data = try Data(contentsOf: imgUrl)
                        } catch let err {
                            print("Error loading picture: \(err)")
                        }
                    }
                    
                    let x = shoeElement(index: index, title: shoe.title!, release: shoe.release!, img: data!, imgUrl: shoe.images!["product"]!, _id: shoe._id!, price: shoe.price!, votes: shoe.votes!)
                    self.appData.releaseList.append(x)
                    index += 1
                }
                self.tblReleases.reloadData()
            } catch {
                print("Error")
            }
            }
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appData.row = 0
        self.appData.releaseList = []
        fetchJSON()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

