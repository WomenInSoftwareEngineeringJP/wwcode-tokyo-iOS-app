import BrightFutures

@testable import WWCode_Tokyo_iOS

class SpyStubEventRepo: EventRepository {
    var getUpcomingEvents_wasCalled: Bool = false
    var getPastEvents_wasCalled: Bool = false
    private(set) var getUpcomingEvents_returnUpcomingEvents = Promise<[Event], RepoError>()
    private(set) var getPastEvents_returnPastEvents = Promise<[Event], RepoError>()

    func getUpcomingEvents() -> Future<[Event], RepoError> {
        getUpcomingEvents_wasCalled = true
        return getUpcomingEvents_returnUpcomingEvents.future
    }
    
    func getPastEvents() -> Future<[Event], RepoError> {
        getPastEvents_wasCalled = true
        return getPastEvents_returnPastEvents.future
    }
}
