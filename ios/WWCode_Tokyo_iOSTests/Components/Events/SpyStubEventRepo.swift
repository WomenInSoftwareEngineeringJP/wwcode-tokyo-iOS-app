import BrightFutures

@testable import WWCode_Tokyo_iOS

class SpyStubEventRepo: EventRepository {
    var getEvents_wasCalled: Bool = false
    private(set) var getEvents_returnEvents = Promise<[Event], RepoError>()

    func getEvents() -> Future<[Event], RepoError> {
        getEvents_wasCalled = true
        return getEvents_returnEvents.future
    }
}
