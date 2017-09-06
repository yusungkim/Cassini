//
//  DemoURL.swift
//  Cassini2
//
//  Created by KimYusung on 10/26/16.
//  Copyright © 2016 yusungkim. All rights reserved.
//

import Foundation
struct DemoURL
{
    static let Standford = URL(string: "http://www.collegeconsensus.com/wp-content/uploads/2016/12/intro_about.jpg")
    
    static var NASA: Dictionary<String, URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://www.jpl.nasa.gov/missions/web/cassini.jpg",
            "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String, URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
