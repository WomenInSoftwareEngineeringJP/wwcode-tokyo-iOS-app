import BrightFutures

protocol EventRepository {
    func getUpcomingEvents() -> Future<[Event], RepoError>
    func getPastEvents() -> Future<[Event], RepoError>
}
