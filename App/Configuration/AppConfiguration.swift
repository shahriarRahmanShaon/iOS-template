import Foundation
import TemplateData

struct AppConfiguration: Sendable {
    var newsFeedBaseURL: URL
    var keychainService: String

    static let `default` = AppConfiguration(
        newsFeedBaseURL: URL(string: "https://api.spaceflightnewsapi.net/v4")!,
        keychainService: "com.template.ios-template"
    )

    var templateDataConfiguration: TemplateDataConfiguration {
        TemplateDataConfiguration(
            newsFeedBaseURL: newsFeedBaseURL,
            keychainService: keychainService
        )
    }
}
