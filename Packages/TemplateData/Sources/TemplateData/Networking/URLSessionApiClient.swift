import Foundation

public struct URLSessionApiClient: ApiClient {
    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder

    public init(baseURL: URL, session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    public func send<Response: Decodable>(_ request: ApiRequest, as type: Response.Type) async throws -> Response {
        let (_, data) = try await perform(request)
        return try decoder.decode(Response.self, from: data)
    }

    private func perform(_ request: ApiRequest) async throws -> (HTTPURLResponse, Data) {
        var components = URLComponents(url: baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: true)
        if !request.queryItems.isEmpty {
            components?.queryItems = request.queryItems
        }
        guard let url = components?.url else {
            SafeLog.httpFault(method: request.method.rawValue, path: request.path, error: ApiClientError.invalidURL)
            throw ApiClientError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let http = response as? HTTPURLResponse else {
                SafeLog.httpFault(method: request.method.rawValue, path: request.path, error: ApiClientError.noResponse)
                throw ApiClientError.noResponse
            }
            SafeLog.httpResponse(method: request.method.rawValue, path: request.path, status: http.statusCode)
            guard (200 ..< 300).contains(http.statusCode) else {
                throw ApiClientError.status(http.statusCode, data)
            }
            return (http, data)
        } catch {
            SafeLog.httpFault(method: request.method.rawValue, path: request.path, error: error)
            throw error
        }
    }
}

public enum ApiClientError: Error {
    case invalidURL
    case noResponse
    case status(Int, Data?)
}
