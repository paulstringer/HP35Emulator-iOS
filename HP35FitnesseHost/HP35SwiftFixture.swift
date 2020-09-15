import Foundation

class HP35SwiftFixture: HP35Fixture {

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
