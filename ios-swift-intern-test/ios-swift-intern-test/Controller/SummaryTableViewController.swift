//
//  SummaryTableViewController.swift
//  iosInternTest
//
//  Created by Clark on 20/9/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class SummaryTableViewController: UITableViewController {

    
    var listData = [SummaryObject]()
    var showListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getShowList(sucessHandler: { (data) in
            self.listData = data
            
            DispatchQueue.global(qos: .background).async {


                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }
            }

            
        }) { (erro) in
            print("ERROR")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return listData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryTableViewCell
        

        cell.name.text = listData[indexPath.section].name
        
        
        if let summaryText = listData[indexPath.section].summary {
            let start = summaryText.index(summaryText.startIndex, offsetBy: 3)
            let end = summaryText.index(summaryText.endIndex, offsetBy: -4)
            
            cell.summary.text = String(summaryText[start ..< end])
        }
        

        let imageurl = URL(string: listData[indexPath.section].image!)!

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageurl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.previewImage.image = image
                    }
                }
            }
        }

        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let vc = segue.destination as? DetailViewController, let indexPath = sender as? IndexPath {
                vc.detailString = listData[indexPath.section].getFormattedOutput()
                vc.originalImageString = listData[indexPath.section].originalImage
                
                vc.urlLink = listData[indexPath.section].url
            }
            
        }
    }


}
