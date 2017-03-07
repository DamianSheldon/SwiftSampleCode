//
//  FilePrivate.swift
//  MyAppWriteWithSwift
//
//  Created by DongMeiliang on 07/03/2017.
//  Copyright © 2017 dongmeilianghy@sina.com. All rights reserved.
//

fileprivate class FilePrivate {
    let constantProperty = 0
    
    var variableProperty = "variableProperty"
    
    func filePrivateMethod() {
        print(#file, #function)
    }
}

extension FilePrivate {
    var description: String {
        return "\(constantProperty): \(variableProperty)"
    }
}
