@testable import WWCode_Tokyo_iOS

struct EventFixture {
    static func JavaScript() -> Event {
        let venue = Venue(
            name: "Code Chrysalis",
            lat: 1.23,
            lon: 4.56,
            address: "venue address",
            city: "venue city")
        
        return Event(
            name: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic",
            startDateTime: "2021-06-12T18:30:00",
            endDateTime: "2021-06-12T21:30:00",
            description: "description",
            venue: venue)
    }

    static func Hackathon() -> Event {
        let venue = Venue(
            name: "Mercari",
            lat: 1.23,
            lon: 4.56,
            address: "venue address",
            city: "venue city")
        
        return Event(
            name: "Hackathon 101 with Junction Tokyo",
            startDateTime: "2021-06-12T18:30:00",
            endDateTime: "2021-06-12T21:30:00",
            description: "description",
            venue: venue)
    }
}
