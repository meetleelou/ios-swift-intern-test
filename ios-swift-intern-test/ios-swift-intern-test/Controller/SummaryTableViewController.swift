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
            
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
 
        }) { (erro) in
            print("ERROR")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryTableViewCell
        

        cell.name.text = listData[indexPath.row].name
        
        
        if let summaryText = listData[indexPath.row].summary {
            let start = summaryText.index(summaryText.startIndex, offsetBy: 3)
            let end = summaryText.index(summaryText.endIndex, offsetBy: -4)
            
            cell.summary.text = String(summaryText[start ..< end])
        }
        

        let imageurl = URL(string: listData[indexPath.row].image!)!

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
                
                vc.name = listData[indexPath.row].name
                vc.number = listData[indexPath.row].number
                vc.season = listData[indexPath.row].season
                vc.airtime = listData[indexPath.row].airtime
                vc.airstamp = listData[indexPath.row].airstamp
                vc.runtime = listData[indexPath.row].runtime
                vc.summary = listData[indexPath.row].summary
                
                vc.urlLink = listData[indexPath.row].url
                vc.originalImageString = listData[indexPath.row].originalImage

            }
            
        }
    }


}
