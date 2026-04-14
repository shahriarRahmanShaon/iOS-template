import Foundation
import TemplateDomain

@MainActor
public final class AuthRepositoryImpl: AuthRepository {
    private let tokenStore: TokenStoring
    private let simulatedDelayNanoseconds: UInt64

    public init(tokenStore: TokenStoring, simulatedDelayNanoseconds: UInt64 = 2_000_000_000) {
        self.tokenStore = tokenStore
        self.simulatedDelayNanoseconds = simulatedDelayNanoseconds
    }

    public var hasStoredCredential: Bool {
        (try? tokenStore.readToken()) != nil
    }

    public func login(email: String, password: String) async throws {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedEmail.isEmpty, !password.isEmpty else {
            throw AuthError.invalidCredentials
        }
        try await Task.sleep(nanoseconds: simulatedDelayNanoseconds)
        let token = "demo-token:\(trimmedEmail.lowercased())"
        try tokenStore.saveToken(token)
        SafeLog.event("auth login stored credential emailLen=\(trimmedEmail.count)")
    }

    public func logout() throws {
        try tokenStore.deleteToken()
        SafeLog.event("auth logout cleared credential")
    }
}

public enum AuthError: Error {
    case invalidCredentials
}
