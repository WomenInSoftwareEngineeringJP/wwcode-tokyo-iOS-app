@testable import WWCode_Tokyo_iOS

class EventRepoSpyStub: EventRepository {
    var getEvents_wasCalled: Bool = false
    var events: [Event] = []
    
    func getEvents() -> [Event] {
        getEvents_wasCalled = true
        return events
    }
}
