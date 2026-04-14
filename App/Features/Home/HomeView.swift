import SwiftUI
import TemplateDomain

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var appController: AppController

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        BaseScreen(viewModel: viewModel) {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Spaceflight headlines")
                            .font(.headline)
                        Text("Live list from the Spaceflight News API. Tap a row for detail.")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.subtitle)
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                }
                Section("Headlines") {
                    if viewModel.articles.isEmpty {
                        ContentUnavailableView(
                            "Nothing loaded yet",
                            systemImage: "tray",
                            description: Text("Tap Refresh to fetch the latest items.")
                        )
                    } else {
                        ForEach(viewModel.articles) { item in
                            Button {
                                coordinator.push(.article(item))
                            } label: {
                                ArticleRow(article: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign out") {
                        appController.logout()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { await viewModel.loadHeadlines() }
                    } label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    }
                }
            }
            .task {
                if viewModel.articles.isEmpty {
                    await viewModel.loadHeadlines()
                }
            }
        }
    }
}

private struct ArticleRow: View {
    let article: NewsArticle

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(article.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
            Text(article.summary)
                .font(.subheadline)
                .foregroundStyle(AppTheme.subtitle)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(AppTheme.card)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(AppTheme.hairline.opacity(0.35), lineWidth: 1)
        )
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
    }
}
