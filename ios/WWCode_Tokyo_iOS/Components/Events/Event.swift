import Foundation

struct Event: Codable, Equatable {
    let name: String
    let startDateTime: String
    let endDateTime: String
    let description: String
    let venue: Venue?
    let link: String
}

struct Venue: Codable, Equatable {
    let name: String
    let location: Location?
}

struct Location: Codable, Equatable {
    let lat: Double
    let lon: Double
    let address: String
    let city: String
}
