import Foundation

@objc(HP35Driver)

class HP35Driver : NSObject {

    let hp35 = HP35CalculatorJS()

    @objc
    func press(_ rawValue: String) {
        if let digitKey = Int(rawValue) { hp35.press(digitKey) }
        if let functionKey = HP35FunctionKey(rawValue: rawValue) { hp35.press(functionKey)
        }
    }

    @objc
    var see: String {
        return  hp35.display
    }
}

public enum HP35FunctionKey: String {
    case ENTER, ADD = "+", SUBTRACT = "-", MULTIPLY = "x", DIVIDE = "÷"
}

protocol HP35Calculator {
    func press(_ key: Int)
    func press(_ key: HP35FunctionKey)
    var display: String { get }
}

class HP35CalculatorJS: HP35Calculator  {

    let jsCalculator = HP35JSDriver()

    func press(_ num: Int) {
        jsCalculator.press(num)
    }

    func press(_ key: HP35FunctionKey) {
        jsCalculator.press("\(key)".lowercased())
    }

    var display: String {
        return jsCalculator.value ?? ""
    }

}

class HP35CalculatorSwift: HP35Calculator {

    private var y : Int?
    private var x = 0

    public func press(_ digit: Int) {
        if y == nil {
            x =  Int( "\(x)\(digit)" ) ?? 0
        } else {
            x = digit
        }
    }

    public func press(_ key: HP35FunctionKey) {
        switch key {
        case .ENTER:
            y = x
        case .ADD:
            x = (y ?? 0 ) + x
        case .SUBTRACT:
            x = (y ?? 0) - x
        case .MULTIPLY:
            x = (y ?? 0) * x
        case .DIVIDE:
            x = (y ?? 0) / x
        }
    }

    public var display : String {
        guard x > 0 else { return  "." }
        return "\(x)."
    }

}
