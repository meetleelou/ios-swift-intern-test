//
//  ViewController.swift
//  iosInternTest
//
//  Created by Clark on 20/9/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

import SafariServices

class DetailViewController: UIViewController {

    
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var details: UILabel!
    
    
    @IBAction func openWebpage(_ sender: UIButton) {
        
        if let link = urlLink {
            let svc = SFSafariViewController(url: URL(string: link)!)
            self.present(svc, animated: true, completion: nil)
        }
        
        
    }

    var detailString: String?
    var originalImageString: String?
    var urlLink: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        details.text = detailString!
        
        let originalImageurl = URL(string: originalImageString!)!

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: originalImageurl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.originalImage.image = image
                    }
                }
            }
        }
        

    }


}

