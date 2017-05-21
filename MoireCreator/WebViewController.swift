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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        
        webView.delegate = self
        
        if category != nil {
            print("category : " + category!)
            self.title = category
        }
        
        if let url = path {
            print("url : " + url)
            if url.hasPrefix("http") {
                print("http")
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
            print("webview loading")
            return
        }
        indicator.stopAnimating()
        print("webview finished")
    }
    
}
