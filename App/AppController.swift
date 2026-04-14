import Combine
import SwiftUI
import TemplateData

@MainActor
final class AppController: ObservableObject {
    @Published private(set) var isAuthenticated: Bool

    let services: TemplateDataServices
    let coordinator: AppCoordinator
    let loginViewModel: LoginViewModel
    let homeViewModel: HomeViewModel

    init(configuration: AppConfiguration = .default) {
        let services = TemplateDataServices(configuration: configuration.templateDataConfiguration)
        self.services = services
        self.coordinator = AppCoordinator()
        self.isAuthenticated = services.authRepository.hasStoredCredential
        self.homeViewModel = HomeViewModel(newsFeedRepository: services.newsFeedRepository)
        self.loginViewModel = LoginViewModel(authRepository: services.authRepository)
        self.loginViewModel.onAuthenticated = { [weak self] in
            self?.isAuthenticated = true
        }
    }

    func logout() {
        try? services.authRepository.logout()
        isAuthenticated = false
    }
}
