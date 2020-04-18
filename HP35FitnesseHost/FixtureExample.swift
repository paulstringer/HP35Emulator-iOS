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
        case zero = "0", one = "1", two = "2", three = "3", ENTER, PLUS = "+"
    }

    public var display : String { return x ?? "." }

    private var x: String?

    public func keyPress(_ key: Key) {
        x = key.rawValue + "."
    }

    public func keyPress(_ key: String) {
        guard let key = Key(rawValue: key) else { return }
        keyPress(key)
    }

}
