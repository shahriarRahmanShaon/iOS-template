import Foundation
import Security

public protocol TokenStoring: Sendable {
    func saveToken(_ token: String) throws
    func readToken() throws -> String?
    func deleteToken() throws
}

public final class KeychainTokenStore: TokenStoring, @unchecked Sendable {
    private let service: String
    private let account: String

    public init(service: String, account: String = "authToken") {
        self.service = service
        self.account = account
    }

    public func saveToken(_ token: String) throws {
        let data = Data(token.utf8)
        try deleteToken()
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.operationFailed(status)
        }
    }

    public func readToken() throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecItemNotFound {
            return nil
        }
        guard status == errSecSuccess, let data = item as? Data else {
            throw KeychainError.operationFailed(status)
        }
        return String(data: data, encoding: .utf8)
    }

    public func deleteToken() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
        ]
        SecItemDelete(query as CFDictionary)
    }
}

public enum KeychainError: Error {
    case operationFailed(OSStatus)
}
