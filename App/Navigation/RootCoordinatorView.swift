import SwiftUI

struct RootCoordinatorView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView(viewModel: homeViewModel)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case let .article(news):
                        ArticleDetailView(article: news)
                    }
                }
        }
    }
}
