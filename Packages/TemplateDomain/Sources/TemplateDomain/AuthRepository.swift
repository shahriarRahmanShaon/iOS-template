import Foundation

@MainActor
public protocol AuthRepository: AnyObject {
    var hasStoredCredential: Bool { get }
    func login(email: String, password: String) async throws
    func logout() throws
}
