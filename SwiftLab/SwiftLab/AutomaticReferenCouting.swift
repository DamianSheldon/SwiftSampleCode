//
//  Person.swift
//  MyAppWriteWithSwift
//
//  Created by dongmeiliang on 6/13/14.
//  Copyright (c) 2014 dongmeilianghy@sina.com. All rights reserved.
//

import Foundation

class Person {
    
    let name: String
    
    var residence: Residence?
    
    init(name: String) {
        
        self.name = name
        
        print("\(name) is being initialized.")
    }
    
    deinit {
        
        print("\(name) is being deInitialized.")
    }
    
}

class Customer {
    
    let name: String
    
    var card: CreditCard?
    
    init(name: String) {
        
        self.name = name
        
    }
    
    deinit {
        
        print("\(name) is being deInitialized.")
    }
}

class CreditCard {
    
    let number: UInt64
    
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        
        self.number = number
        
        self.customer = customer
        
    }
    
    deinit {
        
        print("Card #\(number) is being deInitialized.")
        
    }
}

class Country {

    let name: String

    var capitalCity: City!

    init(name: String, captitalName: String) {

        self.name = name

        self.capitalCity = City(name: captitalName, country: self)

    }
}

class City {

    let name: String

    unowned let country: Country

    init(name: String, country: Country) {

        self.name = name

        self.country = country

    }
}

class HTMLElement {
    
    let name: String
    
    let text: String?
    
    lazy var asHTML: () -> String = {
        
        [unowned self] in
        /*() -> String*/
        if let text = self.text {
            
            return "<\(self.name)>\(text)</\(self.name)>"
            
        } else {
            
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        
        self.name = name
        
        self.text = text
        
    }
    
    deinit {
        
        print("HTMLElement \(name) is being deinitialized.")
        
    }
}

class HTMLElement_StrongReferenceVersion {
    
    let name: String
    
    let text: String?
    
    lazy var asHTML: () -> String = {
        
        /*() -> String*/
        if let text = self.text {
            
            return "<\(self.name)>\(text)</\(self.name)>"
            
        } else {
            
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        
        self.name = name
        
        self.text = text
        
    }
    
    deinit {
        
        print("HTMLElement_StrongReferenceVersion \(name) is being deinitialized.")
        
    }
}
