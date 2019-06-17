//
//  WebViewController.swift
//  InternTask-TVMaze
//
//  Created by Decheng Ma on 17/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var episodeUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        if let episodeUrl = self.episodeUrl {
            let url = URL(string: episodeUrl)
            let request = URLRequest(url: url!)
            webView.load(request)
        }
       
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation
        navigation: WKNavigation!) {
        showActivityIndicator(show: true)
        
        // Remove the indicator either 6 secs later or in didFinish
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            self.showActivityIndicator(show: false)
        })
    }
    
    func webView(_ webView: WKWebView, didFail navigation:
        WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
    
}
