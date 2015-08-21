//
//  MediaItem.swift
//  MyAppWriteWithSwift
//
//  Created by dongmeiliang on 6/13/14.
//  Copyright (c) 2014 dongmeilianghy@sina.com. All rights reserved.
//

//import Foundation

class MediaItem {
    
    var name: String
    
    init(name: String) {
        
        self.name = name
        
    }
}

class Movie: MediaItem {
    
    var director: String
    
    init(name: String, director: String) {
        
        self.director = director
        
        super.init(name: name)
        
    }
}

class Song: MediaItem {
    
    var artist: String
    
    init(name: String, artist: String) {
        
        self.artist = artist
        
        super.init(name: name)
        
    }
}