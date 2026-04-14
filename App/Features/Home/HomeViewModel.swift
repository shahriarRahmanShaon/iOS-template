import Combine
import Foundation
import TemplateDomain

final class HomeViewModel: BaseViewModel {
    private let newsFeedRepository: NewsFeedRepository

    @Published private(set) var articles: [NewsArticle] = []

    init(newsFeedRepository: NewsFeedRepository) {
        self.newsFeedRepository = newsFeedRepository
    }

    func loadHeadlines() async {
        let value = await loadData { try await self.newsFeedRepository.latestArticles(limit: 15) }
        if let value {
            articles = value
        }
    }
}
