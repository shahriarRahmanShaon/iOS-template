import Foundation

public struct NewsArticle: Identifiable, Hashable, Sendable {
    public let id: Int
    public let title: String
    public let summary: String
    public let articleURL: URL?
    public let publishedAt: String?

    public init(id: Int, title: String, summary: String, articleURL: URL?, publishedAt: String?) {
        self.id = id
        self.title = title
        self.summary = summary
        self.articleURL = articleURL
        self.publishedAt = publishedAt
    }
}
