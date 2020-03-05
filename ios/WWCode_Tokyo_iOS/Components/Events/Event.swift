struct Event: Codable {
    let name: String
    let date: String
    let time: String
    let venueName: String
}

extension Event: Equatable {
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.date == rhs.date &&
            lhs.time == rhs.time &&
            lhs.venueName == rhs.venueName
    }
}
