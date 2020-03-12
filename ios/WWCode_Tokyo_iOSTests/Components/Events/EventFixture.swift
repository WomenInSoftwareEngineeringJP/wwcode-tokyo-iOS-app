@testable import WWCode_Tokyo_iOS

struct EventFixture {
    static func JavaScript() -> Event {
        return Event(name: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic", date: "WED 11 MAR", time: "7:30 PM - 9:30 PM", venueName: "Code Chrysalis")
    }

    static func Hackathon() -> Event {
        return Event(name: "Hackathon 101 with Junction Tokyo", date: "WED 05 FEB", time: "6:30 PM - 9:30 PM", venueName: "Mercari")
    }
}
