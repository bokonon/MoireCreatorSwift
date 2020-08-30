//
//  WebViewController.swift
//  MoireCreator
//
//  Created by yuji shimada on 2017/05/20.
//  Copyright © 2017年 yuji shimada. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
  
  @IBOutlet weak var webView: UIWebView!
  
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  
  var category:String?
  var path:String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    indicator.startAnimating()
    indicator.hidesWhenStopped = true
    
    webView.delegate = self
    
    if category != nil {
      #if DEBUG
      print("category : " + category!)
      #endif
      self.title = category
    }
    
    if let url = path {
      #if DEBUG
      print("url : ", url)
      #endif
      if url.hasPrefix("http") {
        #if DEBUG
        print("http")
        #endif
        webView.loadRequest(URLRequest(url: URL(string: url)!))
      } else {
        if let local = Bundle.main.url(forResource: url, withExtension: "html") {
          webView.loadRequest(URLRequest(url: local))
        }
      }
    }
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    if webView.isLoading {
      #if DEBUG
      print("webview loading")
      #endif
      return
    }
    indicator.stopAnimating()
    #if DEBUG
    print("webview finished")
    #endif
  }
  
}

