//
//  EpisodeDetailScreen.swift
//  InternTask-TVMaze
//
//  Created by Decheng Ma on 17/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class EpisodeDetailScreen: UIViewController {
    var episode:Episode?

    @IBOutlet weak var episodeDetailImgView: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeSeasonLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeAirDateLabel: UILabel!
    @IBOutlet weak var episodeAirStampLabel: UILabel!
    @IBOutlet weak var episodeRunTimeLabel: UILabel!
    @IBOutlet weak var episodeHrefLabel: UILabel!
    @IBOutlet weak var eposideSummaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        setValue()
    }
    
    func setupUI(){
        UIView.animate(withDuration: 2.0, delay: 0.0, options:.curveEaseIn, animations: {
            self.view.backgroundColor = BlackGroundBlue
        }, completion:nil)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: optimaRegular, size: 20)!]
        
        episodeDetailImgView.layer.cornerRadius = 15
    }
    
    func setValue(){
        episodeDetailImgView.downloaded(from: episode?.image.original ?? "")
        episodeNameLabel.text = episode?.name
        episodeSeasonLabel.text = "\(episode?.season ?? 0)"
        episodeNumberLabel.text = "\(episode?.number ?? 0)"
        episodeAirDateLabel.text = episode?.airdate
        episodeAirStampLabel.text = episode?.airstamp
        episodeRunTimeLabel.text = "\(episode?.runtime ?? 0)"
        episodeHrefLabel.text = episode?.links.link.data
        eposideSummaryTextView.text = episode?.summary.stripOutHtml()
        
        eposideSummaryTextView.setContentOffset(.zero, animated: true)
        eposideSummaryTextView.layoutIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webviewSegue" {
            let webviewVC = segue.destination as! WebViewController
            webviewVC.episodeUrl = episode?.url
            
        }
    }
    
}
