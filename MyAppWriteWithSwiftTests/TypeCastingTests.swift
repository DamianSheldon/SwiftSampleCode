//
//  TypeCastingTests.swift
//  MyAppWriteWithSwift
//
//  Created by Meiliang Dong on 8/20/15.
//  Copyright (c) 2015 dongmeilianghy@sina.com. All rights reserved.
//

import UIKit
import XCTest

class TypeCastingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTypeCheckOperator() {
        
        let library = [
            
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        
        var movieCount = 0
        
        var songCount = 0
        
        for item in library {
            
            if item is Movie {
                
                ++movieCount
                
            } else if item is Song {
                
                ++songCount
                
            }
        }
        
        XCTAssertTrue(movieCount == 2 && songCount == 3, "Pass")        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
