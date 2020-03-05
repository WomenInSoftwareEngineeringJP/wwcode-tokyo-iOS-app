import Quick

struct AsyncExpectation {
    
    static func execute(
        description: String = "",
        timeout: TimeInterval = 1.0,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: (XCTestExpectation) -> Void
    ) {
        let testExpectation = QuickSpec.current.expectation(description: description)

        closure(testExpectation)

        QuickSpec
            .current
            .waitForExpectations(timeout: timeout, handler: { maybeError in
                guard let _ = maybeError else {
                    return
                }

                XCTFail("Async operation timed out.", file: file, line: line)
            })
    }
}
