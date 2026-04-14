import Foundation

struct ArticlesEnvelopeDTO: Decodable, Sendable {
    let results: [SpaceArticleDTO]
}

struct SpaceArticleDTO: Decodable, Sendable {
    let id: Int
    let title: String
    let summary: String?
    let url: String?
    let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, summary, url
        case publishedAt = "published_at"
    }
}
