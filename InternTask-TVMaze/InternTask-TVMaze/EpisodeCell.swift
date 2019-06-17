//
//  EpisodeCell.swift
//  InternTask-TVMaze
//
//  Created by Decheng Ma on 17/6/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var episodeTextView: UITextView!
    
    func setEpisode(episode:Episode){
        episodeImageView.downloaded(from: episode.image.medium)
        episodeTextView.text = episode.summary.stripOutHtml()
        
        episodeTextView.setContentOffset(.zero, animated: true)
        episodeTextView.layoutIfNeeded()
    }
    
}


