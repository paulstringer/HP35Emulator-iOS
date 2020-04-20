import Foundation

@objc(HP35Driver)

class HP35Driver : NSObject {

    let hp35 = HP35Calculator()

    @objc
    func press(_ key: String) {
        hp35.keyPress(key)
    }

    @objc
    var see: String {
        return  hp35.display
    }
}


class HP35Calculator {

    public enum Key: String {
        case one = "1", two = "2", three = "3"
    }

    public enum ArithmeticKey: String {
        case ENTER, PLUS = "+", SUBTRACT = "-"
    }

    private var y : Int?
    private var x = 0

    private func digitKeyPress(_ key: Key) {
        if y == nil {
            x = Int( "\(x)\(key.rawValue)" ) ?? 0
        } else {
            x = Int(key.rawValue)!
        }
    }

    private func arithmeticKeyPress (_ key: ArithmeticKey) {
        switch key {
        case .ENTER:
            y = x
        case .PLUS:
            x = (y ?? 0) + x
        case .SUBTRACT:
            x = (y ?? 0) - x
        }
    }

    public func keyPress(_ key: String) {
        if let digitKey = Key(rawValue: key) {  digitKeyPress(digitKey) }
        if let arithmeticKey = ArithmeticKey(rawValue: key ) { arithmeticKeyPress(arithmeticKey) }
    }

    public var display : String {
        guard x > 0 else { return  "." }
        return "\(x)."
    }

}
