import Foundation

public struct ProjectNameApiClient: ApiClient {
    private let inner: URLSessionApiClient

    public init(baseURL: URL, session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        inner = URLSessionApiClient(baseURL: baseURL, session: session, decoder: decoder)
    }

    public func send<Response: Decodable>(_ request: ApiRequest, as type: Response.Type) async throws -> Response {
        try await inner.send(request, as: type)
    }
}
