//
//  SecondViewController.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

struct History {
    var product_id: String
    var title: String
    var img: String
    
    init(json: [String: Any]) {
        product_id = json["product_id"] as! String
        title = json["title"] as! String
        img = json["image"] as! String
    }
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
}

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var historys : [History] = []
    var appData = ShoesData.shared
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product_id = historys[indexPath.row].product_id
        for i in 0..<appData.releaseList.count {
            if appData.releaseList[i]._id == product_id {
                appData.row = i
            }
        }
        performSegue(withIdentifier: "toShoeDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        let history = historys[indexPath.row]
        cell.title?.text = history.title
        if let imgUrl = URL(string: history.img) {
            do {
                let data = try Data(contentsOf: imgUrl)
                cell.img.image = UIImage(data: data)
            } catch let err {
                print(err)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    
    //var user : String? = nil
    
    @IBOutlet weak var UsernameLb: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = appData.username {
            UsernameLb.text = user
            imageView.image = UIImage(named: "user-circle")
            loadHistorys()
        }
        self.historyTable.dataSource = self
        self.historyTable.delegate = self
        self.historyTable.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (appData.username == nil) {
            performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    func loadHistorys() {
        let username = appData.username!
        guard let url = URL(string: "https://graliz-account.herokuapp.com/history?username=\(username)") else { return }
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            guard let data = data, err == nil else {
                return
            }
            let stringData = String(data: data, encoding: .utf8)
            print(stringData as Any)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if let historyArray = json as? [Any] {
                    for history in historyArray {
                        self.historys.append(History(json: history as! [String : Any]))
                    }
                    DispatchQueue.main.async {
                        self.historyTable.reloadData()
                    }
                }
            } catch let jsonErr {
                print("Error serialize json: ", jsonErr)
            }
        }.resume()
    }
    
}

