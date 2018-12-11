//
//  ShoeDetailsViewController.swift
//  Grailz
//
//  Created by Nathan Han on 11/29/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit
import AVKit

class YoutubeCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
}

struct YouTubeVideo {
    var title: String
    var desc: String
    var img: String
    var url: String
    
    init(json: [String: Any]) {
        let id = json["id"] as! [String: Any]
        let snippet = json["snippet"] as! [String: Any]
        
        url = "https://www.youtube.com/watch?v=" + (id["videoId"] as! String)
        title = snippet["title"] as! String
        desc = snippet["description"] as! String
        let thumb = snippet["thumbnails"] as! [String: Any]
        let defaultThumb = thumb["default"] as! [String: Any]
        img = defaultThumb["url"] as! String
        
    }
}

class ShoeDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblVideoReviews: UITableView!
    @IBOutlet weak var btnCop: UIButton!
    @IBOutlet weak var btnPass: UIButton!
    
    
    var youTubeVideos : [YouTubeVideo] = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: youTubeVideos[indexPath.row].url),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youTubeVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "youTubeCell", for: indexPath) as! YoutubeCell
        let video = youTubeVideos[indexPath.row]
        cell.title?.text = video.title
        cell.desc?.text = video.desc
        if let imgUrl = URL(string: video.img) {
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
        return 90
    }
    
    var appData = ShoesData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonShadow(button: btnCop)
        buttonShadow(button: btnPass)
        
        imgPic.image = UIImage(data: appData.releaseList[appData.row].img)
        lblTitle.text = appData.releaseList[appData.row].title
        lblRelease.text = date()
        
        self.tblVideoReviews.dataSource = self
        self.tblVideoReviews.delegate = self
        self.tblVideoReviews.tableFooterView = UIView()
        loadURL()
        if appData.username != nil {
            sendHistoryToServer()
            
        }
    }
    
    func sendHistoryToServer() {
        let username = appData.username!
        let id = appData.releaseList[appData.row]._id
        let title = appData.releaseList[appData.row].title
        let image = appData.releaseList[appData.row].imgUrl
        
        var request = URLRequest(url: URL(string: "https://graliz-account.herokuapp.com/history")!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "username=\(username)&product_id=\(id)&title=\(title)&image=\(image)"
        request.httpBody = postString.data(using: .utf8)
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                guard let data = data, err == nil else {
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    if let err = json["error"] as? String {
                        let alert = UIAlertController(title: "Error", message: err, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } catch let jsonErr {
                    print("Error serialize json: ", jsonErr)
                }
                }.resume()
        }
    }
    
    func date() -> String {
        let date = self.appData.releaseList[appData.row].release.components(separatedBy: "-")
        let year = date[0]
        var month = date[1]
        let dayTime = date[2]
        let day = dayTime.components(separatedBy: "T")[0]
        
        switch month {
        case "01":
            month = "January"
        case "02":
            month = "February"
        case "03":
            month = "March"
        case "04":
            month = "April"
        case "05":
            month = "May"
        case "06":
            month = "June"
        case "07":
            month = "July"
        case "08":
            month = "August"
        case "09":
            month = "September"
        case "10":
            month = "October"
        case "11":
            month = "November"
        case "12":
            month = "December"
        default:
            month = "error"
        }
        return "\(month) \(day)"
    }
    
    func buttonShadow(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
    }
    
    func loadURL() {
        let keyword = "\(appData.releaseList[appData.row].title) review"
        // TODO use an actual keyword after sneaker data is loaded
        let apiKey = "AIzaSyDpvNb3Ro5qwtCbZAekxgbMzbPvSrEV4so"
        let urlString = "https://www.googleapis.com/youtube/v3/search"
        var youtubeURL = URLComponents(string: urlString)
        youtubeURL?.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "maxResults", value: "2"),
            URLQueryItem(name: "q", value: keyword),
            URLQueryItem(name: "type", value: "video"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        URLSession.shared.dataTask(with: (youtubeURL?.url)!) { (data, response, err) in
            if let error = err {
                print("URL Session Error: ", error)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    if let videoArray = json["items"] as? [Any] {
                        for video in videoArray {
                            self.youTubeVideos.append(YouTubeVideo(json: video as! [String : Any]))
                        }
                        DispatchQueue.main.async {
                            self.tblVideoReviews.reloadData()
                        }
                    }
                } catch let jsonErr {
                    print("Error serialize json: ", jsonErr)
                }
            }
            }.resume()
    }
    
    @IBAction func btnCop(_ sender: Any) {
        print("Cop")
        //        getVotes()
        //        postSetup()
        //        getVotes()
    }
    
    @IBAction func btnPass(_ sender: Any) {
        print("Pass")
    }
    
    func getVotes() {
        guard let url = URL(string: "http://grailz.herokuapp.com/api/product/\(appData.releaseList[appData.row]._id)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    public func postSetup() {
        let parameters = ["result": 0]
        
        guard let url = URL(string: "http://grailz.herokuapp.com/api/product/\(appData.releaseList[appData.row]._id)/vote") else {return}
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    public func postVote(vote: Int) {
        //        print("http://grailz.herokuapp.com/api/product/\(appData.releaseList[appData.row]._id)")
        //
        //        let parameters = ["votes": appData.releaseList[appData.row]]
        //
        //        guard let url = URL(string: "http://grailz.herokuapp.com/api/product/\(appData.releaseList[appData.row]._id)") else {return}
        //        var request = URLRequest(url: url)
        //        request.httpMethod = "POST"
        //        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        //        request.httpBody = httpBody
        //        let session = URLSession.shared
        //        session.dataTask(with: request) { (data, response, err) in
        //            <#code#>
        //        }
    }
    
}
