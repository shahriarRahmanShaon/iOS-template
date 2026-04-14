import Foundation
import TemplateDomain

@MainActor
public final class TemplateDataServices {
    public let configuration: TemplateDataConfiguration
    public let tokenStore: TokenStoring
    public let userPreferences: UserPreferencesStoring
    public let newsApiClient: URLSessionApiClient
    public let newsFeedRepository: NewsFeedRepository
    public let authRepository: AuthRepository

    public init(
        configuration: TemplateDataConfiguration,
        tokenStore: TokenStoring? = nil,
        userPreferences: UserPreferencesStoring? = nil
    ) {
        self.configuration = configuration
        let resolvedTokenStore = tokenStore ?? KeychainTokenStore(service: configuration.keychainService)
        self.tokenStore = resolvedTokenStore
        self.userPreferences = userPreferences ?? UserPreferencesStore()
        let client = URLSessionApiClient(baseURL: configuration.newsFeedBaseURL)
        self.newsApiClient = client
        let newsService = NewsApiService(client: client)
        self.newsFeedRepository = NewsFeedRepositoryImpl(service: newsService)
        self.authRepository = AuthRepositoryImpl(tokenStore: resolvedTokenStore)
    }
}
