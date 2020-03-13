struct WWCEvent: Codable {
    let name: String
    let date: String
    let time: String
    let venueName: String
}


extension WWCEvent: Equatable {
    static func ==(lhs: WWCEvent, rhs: WWCEvent) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.date == rhs.date &&
            lhs.time == rhs.time &&
            lhs.venueName == rhs.venueName
    }
}

