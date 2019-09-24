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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var airtimeLabel: UILabel!
    @IBOutlet weak var airstampLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel! {
        didSet {
            if let summary = summary {
                summaryLabel.text = NSLocalizedString("summary", comment: "")
                summaryLabel.text! += ": " + randomString + summary
            }
            summaryLabel.sizeToFit()
        }
    }
    
    @IBOutlet weak var linkButton: UIButton!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func openWebpage(_ sender: UIButton) {
        
        if let link = urlLink {
            let svc = SFSafariViewController(url: URL(string: link)!)
            self.present(svc, animated: true, completion: nil)
        }
        
        
    }

    var originalImageString: String?
    var urlLink: String?
    var name: String?
    var number: Int?
    var season: Int?
    var airtime: String?
    var airstamp: String?
    var runtime: Int?
    var summary: String?
    
    
    let randomString = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        linkButton.titleLabel?.text = NSLocalizedString("urlLink", comment: "")
        

        if let name = name {
            nameLabel.text = NSLocalizedString("name", comment: "")
            nameLabel.text! += ": " + name
        }
        
        if let number = number {
            numberLabel.text = NSLocalizedString("number", comment: "")
            numberLabel.text! += ": " + String(number)
        }
        
        if let season = season {
            seasonLabel.text = NSLocalizedString("season", comment: "")
            seasonLabel.text! += ": " + String(season)
        }
        
        if let airtime = airtime {
            airtimeLabel.text = NSLocalizedString("airtime", comment: "")
            airtimeLabel.text! += ": " + airtime
        }
        
        if let airstamp = airstamp {
            airstampLabel.text = NSLocalizedString("airstamp", comment: "")
            
            airstampLabel.text! += ": " + airstamp
        }
        
        if let runtime = runtime {
            runtimeLabel.text = NSLocalizedString("runtime", comment: "")
            runtimeLabel.text! += ": " + String(runtime)
        }
        
        
        
        
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
        
        
        let height = originalImage.bounds.height + nameLabel.bounds.height * 6 + summaryLabel.bounds.height + linkButton.bounds.height
                
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: height)
            
        
         
    }


}

