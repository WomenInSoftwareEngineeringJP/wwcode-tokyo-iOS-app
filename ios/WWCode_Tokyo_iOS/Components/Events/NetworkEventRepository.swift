class NetworkEventRepository: EventRepository {
    private let http: Http

    init(http: Http) {
        self.http = http
    }
    func getEvents() -> [Event] {
        http.get(url: "/api/events")
        return []
    }
}
