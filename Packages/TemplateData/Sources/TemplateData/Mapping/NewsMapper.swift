import Foundation
import TemplateDomain

struct NewsMapper: Sendable {
    func toDomain(_ dto: SpaceArticleDTO) -> NewsArticle {
        let link = dto.url.flatMap { URL(string: $0) }
        return NewsArticle(
            id: dto.id,
            title: dto.title,
            summary: dto.summary ?? "",
            articleURL: link,
            publishedAt: dto.publishedAt
        )
    }
}
