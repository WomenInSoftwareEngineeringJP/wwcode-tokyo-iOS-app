import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventViewControllerTest: QuickSpec {
    override func spec() {
        var subject: EventViewController!
        
        beforeEach {
            let fakeRepo = FakeEventRepo()
            subject = EventViewController(fakeRepo: fakeRepo)
        }
        
        describe("EventViewController") {
            it("shows event") {
                expect(subject.hasLabel(withExactText: "PAL training!")).to(beTrue())
            }
        }
    }
}
