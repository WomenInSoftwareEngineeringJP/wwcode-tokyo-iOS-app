struct NetworkEvent: Codable {
    let name: String
    let date: String
    let time: String
    let duration: Int
    let venueName: String
}


extension NetworkEvent: Equatable {
    static func ==(lhs: NetworkEvent, rhs: NetworkEvent) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.date == rhs.date &&
            lhs.time == rhs.time &&
            lhs.duration == rhs.duration &&
            lhs.venueName == rhs.venueName
    }
}
