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
    
    //description?
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
        return cell
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
                    self.appData.releaseList.append(x)
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
        self.appData.row = 0
        fetchJSON()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

