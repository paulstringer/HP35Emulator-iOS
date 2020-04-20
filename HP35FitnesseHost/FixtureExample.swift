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

    public enum DigitKey: String {
        case one = "1", two = "2", three = "3"
    }

    public enum ArithmeticKey: String {
        case ENTER, PLUS = "+", SUBTRACT = "-"
    }

    private var y : Int?
    private var x = 0

    private func press(_ key: DigitKey) {
        if y == nil {
            x = Int( "\(x)\(key.rawValue)" ) ?? 0
        } else {
            x = Int(key.rawValue)!
        }
    }

    private func press (_ key: ArithmeticKey) {
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
        if let digitKey = DigitKey(rawValue: key) {
            press(digitKey)
        } else if let arithmeticKey = ArithmeticKey(rawValue: key ) {
            press(arithmeticKey)
        }
    }

    public var display : String {
        guard x > 0 else { return  "." }
        return "\(x)."
    }

}
