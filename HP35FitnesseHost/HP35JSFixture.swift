import Foundation

class HP35JSFixture: HP35Fixture  {

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
