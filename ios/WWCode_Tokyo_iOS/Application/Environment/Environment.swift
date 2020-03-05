enum Environment: String {
    case Debug
    case Staging
    case Release

    var baseURL: String {
        switch self {
        case .Debug: return "http://localhost:8080"
        case .Staging: return "https://wwcode-tokyo-server.cfapps.io/"
        case .Release: return ""
        }
    }
}
