import BrightFutures

protocol EventRepository {
    func getEvents() -> Future<[Event], RepoError>
}
