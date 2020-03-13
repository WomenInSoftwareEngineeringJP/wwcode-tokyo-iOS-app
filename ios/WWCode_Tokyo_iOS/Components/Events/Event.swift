import Foundation

struct Event: Codable {
    let name: String
    let startDateTime: String
    let endDateTime: String
    let venueName: String
}

extension Event: Equatable {
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.startDateTime == rhs.startDateTime &&
            lhs.endDateTime == rhs.endDateTime &&
            lhs.venueName == rhs.venueName
    }
}
