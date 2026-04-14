import Foundation
import TemplateDomain

public struct NewsApiService: Sendable {
    private let client: ApiClient
    private let mapper: NewsMapper

    public init(client: ApiClient) {
        self.client = client
        self.mapper = NewsMapper()
    }

    public func fetchLatest(limit: Int) async throws -> [NewsArticle] {
        let envelope: ArticlesEnvelopeDTO = try await client.send(
            ApiRequest(
                path: "articles",
                queryItems: [URLQueryItem(name: "limit", value: "\(limit)")]
            ),
            as: ArticlesEnvelopeDTO.self
        )
        return envelope.results.map { mapper.toDomain($0) }
    }
}
