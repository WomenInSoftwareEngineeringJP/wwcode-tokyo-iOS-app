import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventViewControllerTest: QuickSpec {
    override func spec() {
        var subject: EventViewController!
        
        beforeEach {
            subject = EventViewController(event: EventFixture.JavaScript())
        }
        
        describe("EventViewController") {
            it("shows event title") {
                expect(subject.hasLabel(withExactText: "Jun 12, Sat")).to(beTrue())
                expect(subject.hasLabel(withExactText: "18:30 - 21:30")).to(beTrue())
                expect(subject.hasLabel(withExactText: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")).to(beTrue())
                expect(subject.hasLabel(withExactText: "description")).to(beTrue())
            }
        }
    }
}
