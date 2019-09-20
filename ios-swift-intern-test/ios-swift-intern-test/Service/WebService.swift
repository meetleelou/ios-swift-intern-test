//
//  WebService.swift
//  iosInternTest
//
//  Created by Clark on 20/9/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation


typealias getShowListsuccessHandler = ([SummaryObject]) -> Void
typealias errorHandler = (String?) -> Void



private let TEST_URL = "http://api.tvmaze.com/shows/1/episodes"

func getShowList(sucessHandler: getShowListsuccessHandler? = nil, errorHandler: errorHandler? = nil){

    if let url = URL(string: TEST_URL) {
       URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                
                    // make sure this JSON is in the format we expect
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    // try to read out a string array
                    
                    
                    guard let jsonArray = json as? [[String: Any]] else {
                          return
                    }
                    
                    var allEpisodeObjects = [SummaryObject]()
                    
                    
                    for info in jsonArray {
                        allEpisodeObjects.append(SummaryObject(info: info))
                    }
                    
                    sucessHandler?(allEpisodeObjects)
                    
                    
                    
                } catch let error as NSError {
                
                    print("Failed to load: \(error.localizedDescription)")
                }
           }
       }.resume()
    }
    
    
}
