//
//  StringAndCharacters.swift
//  MyAppWriteWithSwift
//
//  Created by Meiliang Dong on 11/29/14.
//  Copyright (c) 2014 dongmeilianghy@sina.com. All rights reserved.
//

import Foundation

class StringAndCharacters: NSObject {

    func specialUnicodeCharactersInStringLiterals() {
        
        // MARK: Speaial Unicode Characters in String Literals
        
        let wiseWords = "\"Imagination is more important than acknowlege\" - Einstein"
        
        let dollarSign = "\u{24}"
        
        let blackHeart = "\u{2665}"
        
        let sparklingHeart = "\u{1F496}"
        
        print("\(wiseWords)")
        
        print("\(dollarSign)")
        
        print("\(blackHeart)")
        
        print("\(sparklingHeart)")
    }
}
