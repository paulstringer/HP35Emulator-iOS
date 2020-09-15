import Foundation

public enum HP35FunctionKey: String {
    case ENTER, ADD = "+", SUBTRACT = "-", MULTIPLY = "x", DIVIDE = "÷"
}

protocol HP35Fixture {
    func press(_ key: Int)
    func press(_ key: HP35FunctionKey)
    var display: String { get }
}

@objc(HP35Driver)

class HP35Driver : NSObject {

    let hp35: HP35Fixture = HP35JSFixture()

    @objc
    func press(_ rawValue: String) {
        if let digitKey = Int(rawValue) {
            hp35.press(digitKey)
        }
        if let functionKey = HP35FunctionKey(rawValue: rawValue) { hp35.press(functionKey)
        }
    }

    @objc
    var see: String {
        return  hp35.display
    }
}
