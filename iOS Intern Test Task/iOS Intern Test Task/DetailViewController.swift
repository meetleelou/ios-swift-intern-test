//
//  DetailViewController.swift
//  iOS Intern Test Task
//
//  Created by Jackie Wang on 1/4/19.
//  Copyright © 2019 Jackie Wang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var airdateLabel: UILabel!
    @IBOutlet weak var airtimeLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    var name = ""
    var imageURL = ""
    var summary = ""
    var airdate = ""
    var airtime = ""
    var runtime = -1
    var detailLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        let urlimage = URL(string: imageURL)
        URLSession.shared.dataTask(with: urlimage!) {(data, response, err) in
            self.image.image = UIImage(data: data!)
            }.resume()
        summaryLabel.text = summary
        airdateLabel.text = airdate
        airtimeLabel.text = airtime
        runtimeLabel.text = String(runtime)

    }
    
    @IBAction func MoreDetails(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
        vc?.url = self.detailLink
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    


}
