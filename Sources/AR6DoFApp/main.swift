import SwiftUI

@main
struct AppMain {
    static func main() {
        VRApp.main()
    }
}

struct VRApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
