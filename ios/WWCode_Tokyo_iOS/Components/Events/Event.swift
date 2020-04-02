import Foundation

struct Venue: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let address: String
    let city: String
    
    static func ==(lhs: Venue, rhs: Venue) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.lat == rhs.lat &&
            lhs.lon == rhs.lon &&
            lhs.address == rhs.address &&
            lhs.city == rhs.city
    }
}

struct Event: Codable {
    let name: String
    let startDateTime: String
    let endDateTime: String
    let description: String
    let venue: Venue
    let link: String
}

extension Event: Equatable {
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.startDateTime == rhs.startDateTime &&
            lhs.endDateTime == rhs.endDateTime &&
            lhs.description == rhs.description &&
            lhs.venue == rhs.venue &&
            lhs.link == rhs.link
    }
}
