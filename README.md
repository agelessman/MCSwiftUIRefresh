# MCSwiftUIRefresh
Implement pull-down refresh in SwiftUI

![Kapture 2020-07-20 at 9.45.36.gif](https://i.loli.net/2020/07/20/z3QFAvC9VgaT8OM.gif)

![企业微信截图_fa5a3d8b-c6d2-45b4-bbfc-a11dc6e1eece.png](https://i.loli.net/2020/07/20/c25RLj98wvdYo31.png)

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
