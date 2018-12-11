//
//  LoginViewController.swift
//  Grailz
//
//  Created by Jue Chen on 12/9/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    
    
    //var user : String? = nil
    var appData = ShoesData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTouchUpInside(_ sender: Any) {
        let email = emailTF.text
        let pwd = pwdTF.text
        if !((email?.isValidEmail())!) {
            let alert = UIAlertController(title: nil, message: "Invaild Email Adress", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            var request = URLRequest(url: URL(string: "https://graliz-account.herokuapp.com/login")!)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let postString = "email=\(email!)&password=\(pwd!)"
            request.httpBody = postString.data(using: .utf8)
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                guard let data = data, err == nil else {
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    if let result = json["result"] as? String {
                        if result == "success" {
                            //self.user = (json["username"] as! String)
                            self.appData.username = (json["username"] as! String)
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "backAccount", sender: self)
                            }
                        }
                    }
                } catch let jsonErr {
                    print("Error serialize json: ", jsonErr)
                }
                }.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backAccount" {
            let tabVC = segue.destination as! UITabBarController
            tabVC.selectedIndex = 1
        }
    }
    
}


extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
