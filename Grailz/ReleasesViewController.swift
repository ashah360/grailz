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
    let votes: [Int]?
    let _v: Int?
    
    //description?
}

struct shoeElement {
    let index: Int
    let title: String
    let release: String
    let img: Data
}


class ReleasesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblReleases: UITableView!
    
    
    var appData = ShoesData.shared
    
    var releaseList: [shoeElement] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return releaseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReleases.dequeueReusableCell(withIdentifier: "Shoe") as! ShoeCellTableViewCell
        cell.imgPic.image = UIImage(data: self.releaseList[indexPath.row].img)
        cell.lblTitle.text = self.releaseList[indexPath.row].title
        cell.lblRelease.text = self.releaseList[indexPath.row].release
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appData.row = indexPath.row
        appData.title = self.releaseList[appData.row].title
        appData.release = self.releaseList[appData.row].release
        appData.imgUrl = self.releaseList[appData.row].img
        performSegue(withIdentifier: "toShoeDetails", sender: self)
    }
    
    func fetchJSON() {
        let base = "http://grailz.herokuapp.com/api/"
        guard let url =  URL(string: "\(base)product/list") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in DispatchQueue.main.async {
            guard let data = data else { return }
            do {
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
                    
                    let x = shoeElement(index: index, title: shoe.title!, release: shoe.release!, img: data!)
                    self.releaseList.append(x)
                    index += 1
                }
                self.tblReleases.reloadData()
            } catch {
                print("error")
            }
            }
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        appData.row = 0
        fetchJSON()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

