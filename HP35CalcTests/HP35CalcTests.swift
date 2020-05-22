import XCTest
@testable import HP35Calc

class HP35CalcTests: XCTestCase {

    var driver: HP35JSDriver!

    override func setUpWithError() throws {
        driver = HP35JSDriver()
    }

    func testStateEmpty() {
        XCTAssertEqual("0.", driver.value)
    }

    func testPressOneSeeOneDot() {
        driver.press(1)
        XCTAssertEqual("1.", driver.value)
    }

    func testPressOnePlusOneEqualsTwo() {
         driver.press(1)
         driver.press("enter")
         driver.press(1)
         driver.press("add")
         XCTAssertEqual("2.", driver.value)
     }

    func testPressOneDivideByTwo() {
        driver.press(1)
        driver.press("enter")
        driver.press(2)
        driver.press("divide")
        XCTAssertEqual(".5", driver.value)
    }

    func testComplexDivide() {
        driver.press(1)
        driver.press("enter")
        driver.press(2)
        driver.press("divide")
        XCTAssertEqual(".5", driver.value)
    }

}
