//
//  WebViewController.swift
//  iOS Intern Test Task
//
//  Created by Jackie Wang on 1/4/19.
//  Copyright © 2019 Jackie Wang. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url = "www.google.com"
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webURL = URL(string: url)
        let request = URLRequest(url: webURL!)
        
        webView.load(request)
        
    }


}
