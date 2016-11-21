//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let dogString = "Dog‼🐶"

for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}

print("")

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}

print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}

print("")

var shoppingList = ["Eggs", "Milks"]

print("The shopping list contains \(shoppingList.count) items.")

if shoppingList.isEmpty {
    print("The shopping list is empty.")
}
else {
    print("The shopping list is not empty.")
}

shoppingList.append("Flour")

shoppingList += ["Baking Powder"]

shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

shoppingList[4..<6] = ["Bananas", "Apples"]

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

// Pointer
func takesAPointer(_ p: UnsafeMutablePointer<Int>) {
    print("Address Of p is:\(p)")
}

var aIntVar: Int = 1024

takesAPointer(&aIntVar)

let someOptional: Int? = 42
// Match using an enumeration case pattern.
if case .some(let x) = someOptional {
    print(x)
}

// Match using an optional pattern.
if case let x? = someOptional {
    print(x)
}

// Lexical Structure
let a = "a"

let `_` = "_"

print("Identifier\(`_`)")

// Types
// In Swift, there are two kinds of types: named types and compound types.
// A named type is a type that can be given a particular name when it is defined. Named types include classes, structures, enumerations, and protocols.
// Data types that are normally considered basic or primitive in other languages—such as types that represent numbers, characters, and strings—are actually named types, defined and implemented in the Swift standard library using structures.

class ClassType {
    let constantVar = false
    var variable = 1024
}

struct StructType {
    let charConstant: Character = "A"
    var doubleVar = 3.1415926 //If you combine integer and floating-point literals in an expression, a type of Double will be inferred from the context
}

enum EnumType {
    case case1
    case case2
    case case3
}

protocol ProtocolType {
    var property: Array<Int> {get set}
    func function<T:ClassType, U:ProtocolType>(external_parameter_name­: U, parameterLabel parameterArgument: T) -> String
}

// A compound type is a type without a name, defined in the Swift language itself. There are two compound types: function types and tuple types.

var funcTypeVar: (Int, String) -> Bool

var tupleTypeVar = (intVar: Int, stringVar: String).self

// Curried function
/*
 There’s a difference between self.methodname (which you are using), and Classname.methodname.
 
 The former, when called within a class’s method, will give you a function bound with that class instance. So if you call it, it will be called on that instance.
 
 The latter gives you a curried function that takes as an argument any instance of Classname, and returns a new function that is bound to that instance. At this point, that function is like the first case (only you can bind it to any instance you like).
 Reference:[Curried functions in SWIFT](http://stackoverflow.com/questions/27644702/curried-functions-in-swift)
 */

class C {
    private let _msg: String
    init(msg: String) { _msg = msg }
    
    func c_print() { print(_msg) }
    
    func getPrinter() -> ()->() { return self.c_print }
}

let c = C(msg: "woo-hoo")
let f = c.getPrinter()
// f is of type (())->()
f() // prints "woo-hoo"

let d = C(msg: "way-hey")

let g = C.c_print
// g is of type (C) -> (()) -> (),
// you need to feed it a C:
g(c)() // prints "woo-hoo"
g(d)() // prints "way-hey"

// instead of calling immediately,
// you could store the return of g:
let h = g(c)
// at this point, f and h amount to the same thing:
// h is of type (())->()
h() // prints "woo-hoo"

// immutable and mutable
let immutable = "immutable"

var mutable: String = immutable

mutable.append("+mutable")

// Calendar Arithmetic
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "EEEE"

let today = Date()
let calendar = Calendar.current

for i in 1...9 {
    if let date = calendar.date(byAdding: .day, value: i, to: today) {
        print("\(dateFormatter.string(from: date))")
    }
    else {
        print("Date add operate failed!")
    }
    
}

dateFormatter.dateFormat = "HH"

print("\(dateFormatter.string(from: today))")

let date = calendar.date(byAdding: .hour, value: 0, to: today)

print("\(dateFormatter.string(from: date!))")



