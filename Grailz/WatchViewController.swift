//
//  WatchViewController.swift
//  Grailz
//
//  Created by James S. Lee on 12/10/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "WatchShoeCell"

class WatchViewController: UICollectionViewController {
  
  var shoeList = [Shoe]()
  var appData = ShoesData.shared
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpShoes()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    
    AppDelegate.AppUtility.lockOrientation(.portrait)
    
  }
  
  
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    
    AppDelegate.AppUtility.lockOrientation(.all)
    
  }
  
  // Stores the records of shoes from Data.swift
  private func setUpShoes() {
    for i in 0..<appData.releaseList.count {
      shoeList.append(Shoe(shoeName: appData.releaseList[i].title, shoeImage:appData.releaseList[i].img))
    }
  }
  
  override open var shouldAutorotate: Bool {
    return false
  }
  
}

extension WatchViewController: UICollectionViewDelegateFlowLayout {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return shoeList.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WatchShoeCell
    cell.ShoeImageView.image = UIImage(data: shoeList[indexPath.item].shoeImage)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    return CGSize(width: itemSize, height: itemSize)
  }
  
}
