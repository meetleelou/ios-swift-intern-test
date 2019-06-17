//
//  EpisodeListScreen.swift
//  InternTask-TVMaze
//
//  Created by Decheng Ma on 17/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

struct Episode: Codable{
    let id, number, season, runtime:Int
    let url, name, airdate, airstamp, summary:String
    let image: EpisodeImage
    let links: LinkData
    
    enum CodingKeys:String, CodingKey {
        case id, number, season, url, name, airdate, airstamp, runtime, summary, image
        case links = "_links"
    }
}

struct LinkData: Codable{
    let link:Link
    
    enum CodingKeys:String, CodingKey {
        case link = "self"
    }
}

struct Link: Codable {
    let data: String
    
    enum CodingKeys:String, CodingKey {
        case data = "href"
    }
}

struct EpisodeImage: Codable {
    let medium, original:String
    
    enum CodingKeys:String, CodingKey {
        case medium, original
    }
}

class EpisodeListScreen: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var episodes:[Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        self.title = "Episode List"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: optimaRegular, size: 20)!]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchEpisode()
    }
    
    func fetchEpisode() {
        guard let url = URL(string: "http://api.tvmaze.com/shows/1/episodes") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                self.episodes = try JSONDecoder().decode(Array<Episode>.self, from: dataResponse)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "episodeSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                let detailVC = segue.destination as! EpisodeDetailScreen
                detailVC.title = "Episode Detail"
                detailVC.episode = self.episodes[selectedRow]
            }
        }
    }
    
}


extension EpisodeListScreen:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell") as! EpisodeCell
        cell.setEpisode(episode: episode)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
