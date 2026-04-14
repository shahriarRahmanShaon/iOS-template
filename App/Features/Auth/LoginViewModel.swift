import Combine
import Foundation
import TemplateDomain

final class LoginViewModel: BaseViewModel {
    private let authRepository: AuthRepository
    var onAuthenticated: (() -> Void)?

    @Published var email = ""
    @Published var password = ""

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func login() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            try await authRepository.login(email: email, password: password)
            onAuthenticated?()
        } catch {
            errorMessage = String(describing: error)
        }
    }
}
