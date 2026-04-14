import Combine
import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    init() {}

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
