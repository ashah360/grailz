//
//  SearchViewController.swift
//  Grailz
//
//  Created by Nathan Han on 12/7/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var SearchTableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var shoeList = [Shoe]()
    var currentResults = [Shoe]()
    let appData = ShoesData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpShoes()
        setUpSearchBar()
    }
    
    // Stores the records of shoes from Data.swift
    private func setUpShoes() {
        for i in 0..<appData.releaseList.count {
            shoeList.append(Shoe(shoeName: appData.releaseList[i].title, shoeImage:appData.releaseList[i].img))
        }
        currentResults = shoeList
    }
    
    // Sets the search bar delegate to the search view controller
    private func setUpSearchBar() {
        SearchBar.delegate = self
    }
    
    // Triggered whenever the text is changed, and returns relevant results
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Checks if the search text is empty
        // if so, reload that data with all shoe products
        guard !searchText.isEmpty else {
            currentResults = shoeList
            SearchTableView.reloadData()
            return
        }
        // Filters shoe names by search text
        currentResults = shoeList.filter({shoe -> Bool in
            guard let text = searchBar.text else {
                return false
            }
            return shoe.shoeName.lowercased().contains(text.lowercased())
        })
        SearchTableView.reloadData()
    }
    
    // Triggered when the search on keyboard is pressed and hides keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentResults.count
    }
    
    // Table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // Table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appData.row = indexPath.row
        performSegue(withIdentifier: "toShoeDetailsFromSearch", sender: self)
    }
    
    // Table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoeSearchResult") as? SearchShoeResultCell else {
            return UITableViewCell()
        }
        cell.ShoeName.text = currentResults[indexPath.row].shoeName
        cell.ShoeImageView.image = UIImage(data: currentResults[indexPath.row].shoeImage)
        return cell
    }
}

class Shoe {
    let shoeName: String
    var shoeImage: Data = Data()
    
    init(shoeName: String, shoeImage: Data) {
        self.shoeName = shoeName
        self.shoeImage = shoeImage
    }
}
