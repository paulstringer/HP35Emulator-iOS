import Foundation

@objc(HP35Driver)

class HP35Driver : NSObject {

    let hp35 = HP35Calculator()

    @objc
    func press(_ rawValue: String) {
        if let digitKey = Int(rawValue) { hp35.press(digitKey) }
        if let functionKey = HP35Calculator.FunctionKey(rawValue: rawValue) { hp35.press(functionKey) }
    }

    @objc
    var see: String {
        return  hp35.display
    }
}


class HP35Calculator {

    public enum FunctionKey: String {
        case ENTER, PLUS = "+", MINUS = "-", MULTIPLY = "x", DIVIDE = "÷"
    }

    private var y : Int?
    private var x = 0

    public func press(_ digit: Int) {
        if y == nil {
            x =  Int( "\(x)\(digit)" ) ?? 0
        } else {
            x = digit
        }
    }

    public func press(_ key: FunctionKey) {
        switch key {
        case .ENTER:
            y = x
        case .PLUS:
            x = (y ?? 0 ) + x
        case .MINUS:
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
