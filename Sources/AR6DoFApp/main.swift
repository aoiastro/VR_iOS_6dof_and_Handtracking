import SwiftUI

@main
struct AR6DoFAppMain {
    static func main() {
        if #available(iOS 16.0, *) {
            AR6DoFApp().main()
        } else {
            fatalError("iOS 16.0以上が必要です")
        }
    }
}
