//
//  InfoViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/05/20.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var bannerView: GADBannerView!
  
  let categoryArray = ["privacy policy", "license", "version"]
  let categoryDic: [String : String] = ["privacy policy":"https://things-around.netlify.app/privacy", "license":"license", "version":"version"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // AdMob load
    bannerView.adUnitID = ApiConstants.admobUnitID
    bannerView.rootViewController = self
    bannerView.load(GADRequest())
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segue_for_webview" {
      let webViewController = segue.destination as! WebViewController
      if let category = sender as? String {
        webViewController.category = category
        if let path = categoryDic[category] {
          webViewController.path = path
        }
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryArray.count
  }
  
  func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    #if DEBUG
    print("indexPath.row : " + String(describing: indexPath.row))
    #endif
    let cell = table.dequeueReusableCell(withIdentifier: "InfoTableCell", for: indexPath)
    cell.textLabel?.text = categoryArray[indexPath.row]
    
    return cell
  }
  
  func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "segue_for_webview", sender: categoryArray[indexPath.row])
  }
  
}

