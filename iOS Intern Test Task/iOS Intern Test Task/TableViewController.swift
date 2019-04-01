//
//  TableViewController.swift
//  iOS Intern Test Task
//
//  Created by Jackie Wang on 1/4/19.
//  Copyright © 2019 Jackie Wang. All rights reserved.
//

import UIKit

struct DImage: Decodable {
    var medium: String
    var original: String
}

struct Links: Decodable {
    struct `self`: Decodable {
        var href: String
    }
}

struct CellData: Decodable {
    var id: Int
    var url: String
    var name: String
    var season: Int
    var number: Int
    var airdate: String
    var airtime: String
    var airstamp: String
    var runtime: Int
    var image: DImage
    var summary: String
}

class TableViewController: UITableViewController {
    
    var AllData = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(Customcell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableView.automaticDimension
        fetchData()
    }
    
    func fetchData() {
        let jsonUrlString = "https://api.tvmaze.com/shows/1/episodes"
        guard let url = URL(string: jsonUrlString) else
        { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            //check err
            //check status 200 OK
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                
                self.AllData = try
                    decoder.decode([CellData].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
//                print(self.AllData)
            } catch let jsonErr {
                print("Error", jsonErr)
            }
            
            }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! Customcell
        let imageURL = AllData[indexPath.row].image.medium
        let urlimage = URL(string: imageURL)
        URLSession.shared.dataTask(with: urlimage!) {(data, response, err) in
            cell.mainImage = UIImage(data: data!)
        }.resume()
        cell.message = AllData[indexPath.row].summary
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.name = AllData[indexPath.row].name
        vc?.imageURL = AllData[indexPath.row].image.original
        vc?.summary = AllData[indexPath.row].summary
        vc?.airdate = AllData[indexPath.row].airdate
        vc?.airtime = AllData[indexPath.row].airtime
        vc?.runtime = AllData[indexPath.row].runtime
        vc?.detailLink = AllData[indexPath.row].url

        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
