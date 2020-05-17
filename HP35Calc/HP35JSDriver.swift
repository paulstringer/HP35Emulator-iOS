import Foundation
import JavaScriptCore

class HP35JSDriver {

    let context: JSContext
    let sourceURL: URL
    var value: String?

    init() {
        self.context = JSContext()
        self.sourceURL = Bundle.main.url(forResource: "HP35", withExtension: "js")!
    }

    public func press(_ key : String) {
       context.evaluateScript("key_\(key)()", withSourceURL: sourceURL)
        value = context.objectForKeyedSubscript("d")?.toString()
    }

    public func press(_ digit: Int) {
        context.evaluateScript("key_num(\(digit)", withSourceURL: sourceURL)
    }

}
