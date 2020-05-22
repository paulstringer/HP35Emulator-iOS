import Foundation
import JavaScriptCore

class HP35JSDriver {

    let context: JSContext

    var value: String? {
        let value = context.evaluateScript("d")
        return value?.toString()?.trimmingCharacters(in: .whitespaces)
    }

    init() {
        self.context = JSContext(virtualMachine: JSVirtualMachine())
        self.context.exceptionHandler = exceptionHandler
        let script = HP35JSDriver.jsSource()
        self.context.evaluateScript(script)
    }

    public func press(_ key : String) {
       context.evaluateScript("key_\(key)()")
    }

    public func press(_ digit: Int) {
        context.evaluateScript("key_num(\(digit))")
    }

    private func exceptionHandler(context: JSContext?, exception: JSValue?) {
        print("JavaScript Exception! \(exception?.toString() ?? "")")
    }

    private static func jsSource() -> String {
        let sourceURL = Bundle.main.url(forResource: "HP35", withExtension: "js")!
        return try! String(contentsOf: sourceURL, encoding: .utf8)
    }


}
