//
//  MyAppWriteWithSwiftTests.swift
//  MyAppWriteWithSwiftTests
//
//  Created by dongmeiliang on 6/9/14.
//  Copyright (c) 2014 dongmeilianghy@sina.com. All rights reserved.
//

import XCTest
@testable import MyAppWriteWithSwift

class MyAppWriteWithSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAutoReferenceCount() {
        
        var reference1: Optional<Person>
        
        var reference2: Person?
        
        var reference3: Person?
        
        reference1 = Person(name: "John Appleseed")
        
        reference2 = reference1
        
        reference3 = reference1
        
        reference2 = nil
        
        reference3 = nil
        
        reference1 = nil
        
        XCTAssert(true, "Pass")
    }
    
    func testUnownedReference() {
        
        var john: Customer?
        
        john = Customer(name: "John Appleseed")
        john!.card = CreditCard(number: 1234567890123456, customer: john!)
        
        XCTAssertTrue(true, "Pass")
    }
    
    func testUnownedReferenceAndImplicityUnwrappedOptional() {
        
        let country = Country(name: "Canada", captitalName: "Ottawa")
        
        print("\(country.name)'capital city is called \(country.capitalCity.name)")
        
        XCTAssertTrue(true, "Pass")
    }
    
    func testShowStrongReferenceCyclesForClosures() {
        var paragraph: HTMLElement_StrongReferenceVersion? = HTMLElement_StrongReferenceVersion(name: "p", text: "testShowStrongReferenceCyclesForClosures")
        
        print(paragraph?.asHTML() ?? "paragraph inner HTML's content absense")
        
        paragraph = nil
        
        XCTAssertTrue(true, "Pass")
    }
    
    func testResolvingStrongReferenceCyclesForClosures() {
        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "testResolvingStrongReferenceCyclesForClosures")
        
        print(paragraph?.asHTML() ?? "paragraph inner HTML's content absense")

        paragraph = nil
        
        XCTAssertTrue(true, "Pass")
    }
    
    func testStringAndCharacters() {
                
        let aStringAndCharacters = StringAndCharacters()
        aStringAndCharacters.specialUnicodeCharactersInStringLiterals()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
