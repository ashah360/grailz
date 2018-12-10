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
    

    var user : String? = nil
    
    @IBOutlet weak var UsernameLb: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (user != nil) {
            UsernameLb.text = "Hi, " + user! + " !"
            self.historyTable.dataSource = self
            self.historyTable.delegate = self
            self.historyTable.tableFooterView = UIView()
            loadHistorys()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (user == nil) {
            performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    func loadHistorys() {
        URLSession.shared.dataTask(with: URL(string: "http://grailz-account.herokuapp.com/history?username=\(user!)")!) {
            (data, response, err) in
            guard let data = data, err == nil else {
                return
            }
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
        }
    }

}

