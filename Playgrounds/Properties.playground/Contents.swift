//: Playground - noun: a place where people can play

// MARK: Global and Local Variables

var global = "Global" {
    willSet(newString) {
        print("\(#function):\(newString)")
    }
    didSet(oldString) {
        print("\(#function):\(oldString)")
    }
}

global = "Demonstrate global variable observer"

func aFunction() {
    var localVariabel = false {
        willSet {
            print("\(#function):\(newValue)")
        }
        didSet {
            print("\(#function):\(oldValue)")
        }
    }
    
    localVariabel = !localVariabel
}

aFunction()

// MARK: Type Properties

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

class SubSomeClass: SomeClass {
    override class var overrideableComputedTypeProperty: Int {
        return 108
    }
}