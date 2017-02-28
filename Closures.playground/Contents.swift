//: Playground - noun: a place where people can play

import UIKit

// Escaping Closures

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

// Autoclosures

// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
var customersInLine = ["Alex", "Ewa", "Barry", "Daniella"];

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))