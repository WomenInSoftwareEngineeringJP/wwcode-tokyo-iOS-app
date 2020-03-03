class FakeEventRepo {
    private var events: [Event]
    
    init() {
        events = [
            Event(name: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic", date: "WED 05 FEB", time: "7:30 PM - 9:30 PM", venueName: "Code Chrysalis")
        ]
    }
    
    
    func getEvents() -> [Event] {
        return events
    }
}
