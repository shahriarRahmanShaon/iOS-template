import Foundation

@MainActor
public protocol NewsFeedRepository: AnyObject {
    func latestArticles(limit: Int) async throws -> [NewsArticle]
}
