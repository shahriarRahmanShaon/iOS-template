import Foundation
import TemplateDomain

@MainActor
public final class NewsFeedRepositoryImpl: NewsFeedRepository {
    private let service: NewsApiService

    public init(service: NewsApiService) {
        self.service = service
    }

    public func latestArticles(limit: Int) async throws -> [NewsArticle] {
        try await service.fetchLatest(limit: limit)
    }
}
