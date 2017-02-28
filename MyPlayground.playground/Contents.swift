//: Playground - noun: a place where people can play

import UIKit

//: Functions
//: 1. Defining and calling functions
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))

print(greet(person: "Brain"))

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}

//: 2. Function parameters and return values
func sayHelloWorld() -> String {
    return "Hello, World!"
}

print(sayHelloWorld())

func greet(person: String, aleadyGreeted: Bool) -> String {
    if aleadyGreeted {
        return greet(person: person)
    }
    else {
        return greetAgain(person: person)
    }
}

print(greet(person: "Tim", aleadyGreeted: true))

func greetWithoutReturnValue(person: String) {
    print("Hello, \(person)!")
}

greetWithoutReturnValue(person: "Dave")

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }
        else if value > currentMax {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min), and max is \(bounds.max)")

//: 3. Function argument labels and parameter names
func someFunction(argumentLabel parameterName: Int) {

}

func greet(person: String, from homeTown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(homeTown)"
}

print(greet(person: "Bill", from: "Cupertino"))

func omitingArgumentLabelFunction(_ firstParameterName: Bool, secondParameterName: Int) {
    
}

omitingArgumentLabelFunction(true, secondParameterName: 1024)

//: 4. Function type
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")

//: Subscripts

struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        
        grid = Array(repeating: 0, count: rows * columns)
    }
    
    func indexIsVaild(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsVaild(row: row, column: column), "Index out of range.")
            
            return grid[row * columns + column]
        }
        
        set(newValue) {
            assert(indexIsVaild(row: row, column: column), "Index out of range.")
            
            grid[row * columns + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

//let someValue = matrix[2, 2]

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



