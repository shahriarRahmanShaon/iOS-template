import SwiftUI

struct BaseScreen<ViewModel: BaseViewModel, Content: View>: View {
    @ObservedObject private var viewModel: ViewModel
    private let content: () -> Content

    init(viewModel: ViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }

    var body: some View {
        ZStack {
            content()
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.2)
            }
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            ),
            actions: { Button("OK", role: .cancel) { viewModel.errorMessage = nil } },
            message: { Text(viewModel.errorMessage ?? "") }
        )
    }
}
