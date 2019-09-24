//
//  SummaryModel.swift
//  iosInternTest
//
//  Created by Clark on 20/9/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation


class SummaryObject {
    var id: Int?
    var image: String?
    var originalImage: String?
    
    var name: String?
    var summary: String?

    var airtime: String?
    var airstamp: String?
    var runtime: Int?
    
    var url: String?
    var season: Int?
    var number: Int?
    
   
    
    init(info: [String: Any]){
        id = info["id"] as? Int
        
        if let imageURL = info["image"] as? [String: String] {
            image = imageURL["medium"]
            originalImage = imageURL["original"]
        }
        name = info["name"] as? String
        summary = info["summary"] as? String
        airtime = info["airtime"] as? String
        airstamp = info["airstamp"] as? String
        runtime = info["runtime"] as? Int
        url = info["url"] as? String
        season = info["season"] as? Int
        number = info["number"] as? Int
    }
    
    func getFormattedOutput() -> String {
        
 
        let string = "Name: \(name ?? "unknown")\nSeason: \(season ?? -1)\nNumber: \(number ?? -1)\nAirtime: \(airtime ?? "unknown")\nRuntime: \(runtime ?? -1) minutes\n\nSummary: \(summary ?? "unknown")"
        
       
        
        return string
    }
    
}
