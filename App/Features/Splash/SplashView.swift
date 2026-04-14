import SwiftUI

struct SplashView: View {
    var onFinished: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.10, green: 0.18, blue: 0.42),
                    Color(red: 0.22, green: 0.12, blue: 0.38),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: "newspaper.circle.fill")
                    .font(.system(size: 72))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
                Text("iOS Template")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                ProgressView()
                    .tint(.white)
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 1_400_000_000)
            onFinished()
        }
    }
}
