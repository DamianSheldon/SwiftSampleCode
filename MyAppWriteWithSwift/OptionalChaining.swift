//
//  Room.swift
//  MyAppWriteWithSwift
//
//  Created by dongmeiliang on 6/13/14.
//  Copyright (c) 2014 dongmeilianghy@sina.com. All rights reserved.
//

import Foundation

class Room {
    
    let name: String
    
    init(name: String) {
        
        self.name = name
        
    }
}

class Address {
    
    var buildingName: String?
    
    var buildingNumber: String?
    
    var street: String?
    
    func buildingIdentifier() -> String? {
        
        if (buildingName != nil) {
            
            return buildingName
            
        } else if (buildingNumber != nil) {
            
            return buildingNumber
            
        } else {
            
            return nil
            
        }
    }
    
}

class Residence {
    
    var rooms = [Room]()
    
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        return rooms[i]
    }
    
    func printNumberOfRooms() {
        println("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}