import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        BaseScreen(viewModel: viewModel) {
            VStack {
                Spacer(minLength: 0)
                HStack {
                    Spacer(minLength: 0)
                    VStack(spacing: 24) {
                        VStack(spacing: 8) {
                            Image(systemName: "lock.circle.fill")
                                .font(.system(size: 56))
                                .foregroundStyle(AppTheme.accent)
                            Text("Sign in")
                                .font(.title.bold())
                                .multilineTextAlignment(.center)
                            Text("Demo: any non-empty email and password. Token saved to Keychain after a short delay.")
                                .font(.footnote)
                                .foregroundStyle(AppTheme.subtitle)
                                .multilineTextAlignment(.center)
                        }
                        VStack(spacing: 14) {
                            TextField("Email", text: $viewModel.email)
                                .textContentType(.username)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .padding(14)
                                .background(AppTheme.card)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            SecureField("Password", text: $viewModel.password)
                                .textContentType(.password)
                                .padding(14)
                                .background(AppTheme.card)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        Button {
                            Task { await viewModel.login() }
                        } label: {
                            Text("Continue")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(AppTheme.accent)
                    }
                    .frame(maxWidth: 420)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 24)
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(uiColor: .systemGroupedBackground))
        }
    }
}
