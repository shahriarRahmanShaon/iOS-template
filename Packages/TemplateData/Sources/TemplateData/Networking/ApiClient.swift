import Foundation

public protocol ApiClient: Sendable {
    func send<Response: Decodable>(_ request: ApiRequest, as type: Response.Type) async throws -> Response
}
