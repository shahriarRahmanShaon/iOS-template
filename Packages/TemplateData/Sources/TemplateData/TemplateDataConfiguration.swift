import Foundation

public struct TemplateDataConfiguration: Sendable {
    public let newsFeedBaseURL: URL
    public let keychainService: String

    public init(newsFeedBaseURL: URL, keychainService: String) {
        self.newsFeedBaseURL = newsFeedBaseURL
        self.keychainService = keychainService
    }
}
