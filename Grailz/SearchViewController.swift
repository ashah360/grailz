//
//  SearchViewController.swift
//  Grailz
//
//  Created by James S. Lee on 12/3/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

  
  @IBOutlet weak var SearchTableView: UITableView!
  @IBOutlet weak var SearchBar: UISearchBar!
  
  var shoeList = [Shoe]()
  var currentResults = [Shoe]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpShoes()
    setUpSearchBar()
  }
  
  private func setUpSearchBar() {
    SearchBar.delegate = self
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard !searchText.isEmpty else {
      currentResults = shoeList
      SearchTableView.reloadData()
      return
    }
    currentResults = shoeList.filter({shoe -> Bool in
      guard let text = searchBar.text else {
        return false
      }
      return shoe.shoeName.lowercased().contains(text.lowercased())
    })
    SearchTableView.reloadData()
  }
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
  }
  
  // test data
  private func setUpShoes() {
    shoeList.append(Shoe(shoeName: "a", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "b", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "c", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "d", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "e", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "f", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "g", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "h", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "i", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "j", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "k", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "l", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "m", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "n", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "o", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "p", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "q", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "r", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "s", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "t", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "u", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "v", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "w", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "x", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "y", shoeImage: "bred4s"))
    shoeList.append(Shoe(shoeName: "z", shoeImage: "bred4s"))
    
    currentResults = shoeList
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentResults.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoeSearchResult") as? SearchShoeResultCell else {
      return UITableViewCell()
    }
    cell.ShoeName.text = currentResults[indexPath.row].shoeName
    cell.ShoeImageView.image = UIImage(named: currentResults[indexPath.row].shoeImage)
    return cell
  }
  
}

class Shoe {
  let shoeName: String
  let shoeImage: String
  
  init(shoeName: String, shoeImage: String) {
    self.shoeName = shoeName
    self.shoeImage = shoeImage
  }
}
