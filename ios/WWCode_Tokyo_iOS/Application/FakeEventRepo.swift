class FakeEventRepo {
    private var events: [Event]
    
    init() {
        events = [Event(name: "PAL training!"), Event(name: "Lunch and learn"), Event(name: "Tokyo Olympics")]
    }
    
    func getEvents() -> [Event] {
        return events
    }
}
