//
//  ContentView.swift
//  SwiftUIRefreshDemo
//
//  Created by MC on 2020/7/15.
//

import SwiftUI

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

struct Row: View {
    @StateObject private var imageLoader = CoverImageLoader()

    let article: Article

    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.secondary)
                        .frame(width: 80, height: 120)
                }
                

                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text(article.desc)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.horizontal, 10)

            Divider()
        }
        .onAppear {
            imageLoader.load(article.icon)
        }
    }
}

class CoverImageLoader: ObservableObject {
    @Published var image: UIImage? = nil

    func load(_ imgName: String) {
        URLSession.shared.dataTask(with: URL(string: imgName)!) { data, _, _ in
            if let d = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: d) ?? UIImage(named: "")
                }
            }
        }
        .resume()
    }
}

class MyTestModel: ObservableObject {
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false, loading == true {
                load()
            }
        }
    }

    @Published var articleArray: [Article] = articles

    func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            self.loading = false
            self.articleArray.shuffle()
        }
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
