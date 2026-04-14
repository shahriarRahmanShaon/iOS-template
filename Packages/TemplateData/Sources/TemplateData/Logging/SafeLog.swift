import Foundation
import OSLog

public enum SafeLog {
    private static let network = Logger(subsystem: "com.template.ios-template", category: "network")
    private static let general = Logger(subsystem: "com.template.ios-template", category: "app")

    public static func httpResponse(method: String, path: String, status: Int) {
        network.info("http \(method, privacy: .public) \(path, privacy: .public) \(status, privacy: .public)")
    }

    public static func httpFault(method: String, path: String, error: Error) {
        network.error("http \(method, privacy: .public) \(path, privacy: .public) err=\(error.localizedDescription, privacy: .private)")
    }

    public static func event(_ message: String) {
        general.notice("\(message, privacy: .public)")
    }
}
