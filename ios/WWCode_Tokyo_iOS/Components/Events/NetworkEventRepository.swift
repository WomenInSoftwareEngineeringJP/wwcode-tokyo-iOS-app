import BrightFutures
import Foundation

class NetworkEventRepository: EventRepository {
    private let http: Http

    init(http: Http) {
        self.http = http
    }
    func getUpcomingEvents() -> Future<[Event], RepoError> {
        return http
        .get(url: "/api/events/upcoming")
        .map { data in
            let decoder = JSONDecoder()
            let events = try! decoder.decode([Event].self, from: data)
            return events
        }
        .mapError { httpError in
            return RepoError.undefined
        }
    }
    
    func getPastEvents() -> Future<[Event], RepoError> {
        return http
        .get(url: "/api/events/past")
        .map { data in
            let decoder = JSONDecoder()
            let events = try! decoder.decode([Event].self, from: data)
            return events
        }
        .mapError { httpError in
            return RepoError.undefined
        }
    }
}

enum RepoError: Error {
    case undefined
}
