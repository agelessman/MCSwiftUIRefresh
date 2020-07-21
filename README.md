# MCSwiftUIRefresh
Implement pull-down refresh in SwiftUI

## Usage
```swift
struct ContentView: View {
    @StateObject private var model = MyTestModel()

    var body: some View {
        NavigationView {
            MCRefreshableVerticalScrollView(refreshing: self.$model.loading) {
                VStack(spacing: 0) {
                    ForEach(model.articleArray) { article in
                        Row(article: article)
                    }
                }
            }
            .navigationBarTitle("我的文章", displayMode: .inline)
        }
    }
}
```

If you want to customize the head refresh control, you can directly modify the `RefreshHeader`。
