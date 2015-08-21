//
//  ValueTypesInitializer.swift
//  MyAppWriteWithSwift
//
//  Created by dongmeiliang on 6/13/14.
//  Copyright (c) 2014 dongmeilianghy@sina.com. All rights reserved.
//

import Foundation

// Value Types(enumerations, structures) Initializer

// Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready to for use.

// 1, set an initial value for a stored property within an initializer

struct FahrenheitInitializerVersion {
    
    var temperature: Double
    
    init() {
        
        temperature = 32.0
        
    }
}

// 2, set an initial value for a stored property by assigning a default property value as part of the property’s definition.

struct Fahrenheit {
    
    var temperature = 32.0
    
}

// Default Intializer
// Swift provides a default initializer for any structure or base class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.
class ShoppingListItem {
    
    var name: String?
    
    var quantity: Int = 1
    
    var purchased: Bool = false
    
}
// so class ShoppingListItem's Default Intializer is ShoppingListItem()

// Memberwise Intializers for structure types


// Customizing Initialization

struct Celsius {
    
    var temperatureInCelsius: Double = 0.0
    
    init(fromFahrenheit fahrenheit: Double) {
        
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
        
    }
    
    init(fromKelvin kelvin: Double) {
        
        temperatureInCelsius = kelvin - 273.15
        
    }
}

// Local and External Parameter Names

/*
1, Swift provides an automatic external name for every parameter in an initializer if you don’t provide an external name yourself. This automatic external name is the same as the local name, as if you had written a hash symbol before every initialization parameter.

2, If you do not want to provide an external name for a parameter in an initializer, provide an underscore (_) as an explicit external name for that parameter to override the default behavior described above.

3, We also can provide ourselve's external parameter name as describle in functions.

*/

struct Color {
    
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        
        self.red   = red
        
        self.green = green
        
        self.blue  = blue
    }
}
