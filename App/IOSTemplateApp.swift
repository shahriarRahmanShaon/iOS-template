import SwiftUI

@main
struct IOSTemplateApp: App {
    @State private var showSplash = true
    @StateObject private var appController = AppController()

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView {
                        showSplash = false
                    }
                    .transition(.opacity)
                } else if appController.isAuthenticated {
                    RootCoordinatorView()
                        .environmentObject(appController.coordinator)
                        .environmentObject(appController.homeViewModel)
                        .environmentObject(appController)
                        .transition(.opacity)
                } else {
                    LoginView(viewModel: appController.loginViewModel)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.35), value: showSplash)
            .animation(.easeInOut(duration: 0.25), value: appController.isAuthenticated)
        }
    }
}
