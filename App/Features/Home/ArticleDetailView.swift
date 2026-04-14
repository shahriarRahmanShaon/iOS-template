import SwiftUI
import TemplateDomain

struct ArticleDetailView: View {
    let article: NewsArticle

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(article.title)
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                if let published = article.publishedAt {
                    Text(published)
                        .font(.footnote)
                        .foregroundStyle(AppTheme.subtitle)
                }
                if let url = article.articleURL {
                    Link(destination: url) {
                        Label("Open original article", systemImage: "safari")
                            .font(.subheadline.weight(.semibold))
                    }
                    .tint(AppTheme.accent)
                }
                Text(article.summary)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(20)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Headline")
        .navigationBarTitleDisplayMode(.inline)
    }
}
