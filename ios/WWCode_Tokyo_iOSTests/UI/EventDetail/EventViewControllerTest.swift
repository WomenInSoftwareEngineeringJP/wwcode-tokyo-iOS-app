import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventViewControllerTest: QuickSpec {
    override func spec() {
        var subject: EventViewController!
        
        var spyUrlOpener: SpyUrlOpener!
        
        beforeEach {
            spyUrlOpener = SpyUrlOpener()
            subject = EventViewController(event: EventFixture.JavaScript(), urlOpener: spyUrlOpener)
        }
        
        describe("EventViewController") {
            it("shows event title") {
                expect(subject.hasLabel(withExactText: "Jun 12, Sat")).to(beTrue())
                expect(subject.hasLabel(withExactText: "18:30 - 21:30")).to(beTrue())
                expect(subject.hasLabel(withExactText: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")).to(beTrue())
                expect(subject.hasLabel(withExactText: "description")).to(beTrue())
                expect(subject.hasLabel(withExactText: "Code Chrysalis")).to(beTrue())
                expect(subject.hasLabel(withExactText: "venue address venue city")).to(beTrue())
            }
            
            it("directs to Meetup event page when register button clicked") {
                expect(subject.hasButton(withExactText: "Register")).to(beTrue())
                subject.findButton(withExactText: "Register")?.tapAndFireTargetEvent()
            
                expect(spyUrlOpener.opened_url).to(equal("example.com"))
            }
        }
    }
}
