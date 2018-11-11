//: Playground - noun: a place where people can play

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
        return row > 0 && row < rows && column > 0 && column < rows
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsVaild(row: row, column: column), "Index is out of range")
            
            return grid[row * columns + column]
        }
        
        set {
            assert(indexIsVaild(row: row, column: column), "Index is out of range")
            
            grid[row * columns + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

let someValue = matrix[2, 2]
