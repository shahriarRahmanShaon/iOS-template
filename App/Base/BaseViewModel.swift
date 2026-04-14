import Combine
import Foundation

@MainActor
class BaseViewModel: ObservableObject {
    @Published internal(set) var isLoading = false
    @Published var errorMessage: String?

    init() {}

    @discardableResult
    func loadData<T>(_ operation: @escaping () async throws -> T) async -> T? {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            return try await operation()
        } catch {
            errorMessage = String(describing: error)
            return nil
        }
    }

    @discardableResult
    func loadData<Payload, T>(
        payload: Payload,
        _ operation: @escaping (Payload) async throws -> T
    ) async -> T? {
        await loadData { try await operation(payload) }
    }
}
