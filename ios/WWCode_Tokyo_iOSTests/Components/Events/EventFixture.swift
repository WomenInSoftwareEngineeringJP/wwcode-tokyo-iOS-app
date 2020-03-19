@testable import WWCode_Tokyo_iOS

struct EventFixture {
    static func JavaScript() -> Event {
        return Event(name: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic", startDateTime: "2021-06-12T18:30:00", endDateTime: "2021-06-12T21:30:00", description: "description", venueName: "Code Chrysalis")
    }

    static func Hackathon() -> Event {
        return Event(name: "Hackathon 101 with Junction Tokyo", startDateTime: "2021-06-12T18:30:00", endDateTime: "2021-06-12T21:30:00", description: "description", venueName: "Mercari")
    }
}
