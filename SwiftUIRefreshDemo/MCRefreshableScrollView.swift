//
//  MCRefreshableScrollView.swift
//  SwiftUIRefreshDemo
//
//  Created by MC on 2020/7/16.
//

import SwiftUI

struct MCRefreshableVerticalScrollView<Content: View>: View {
    @State private var preOffset: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var frozen = false
    @State private var rotation: Angle = .degrees(0)
    @State private var updateTime: Date = Date()
    
    var threshold: CGFloat = 70
    @Binding var refreshing: Bool
    let content: Content
    
    init(_ threshold: CGFloat = 70, refreshing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.threshold = threshold
        self._refreshing = refreshing
        self.content = content()
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: .top) {
                    MovingPositionView()
                    
                    VStack {
                        self.content
                            .alignmentGuide(.top, computeValue: { _ in
                                (self.refreshing && self.frozen) ? -self.threshold : 0
                            })
                    }
                    
                    RefreshHeader(height: self.threshold,
                                  loading: self.refreshing,
                                  frozen: self.frozen,
                                  rotation: self.rotation,
                                  updateTime: self.updateTime)
                }
            }
            .background(FixedPositionView())
            .onPreferenceChange(MCRefreshablePreferenceTypes.MCRefreshablePreferenceKey.self) { values in
                self.calculate(values)
            }
            .onChange(of: refreshing) { refreshing in
                DispatchQueue.main.async {
                    if !refreshing {
                        self.updateTime = Date()
                    }
                }
            }
        }
    }
    
    func calculate(_ values: [MCRefreshablePreferenceTypes.MCRefreshablePreferenceData]) {
        DispatchQueue.main.async {
            /// 计算croll offset
            let movingBounds = values.first(where: { $0.viewType == .movingPositionView })?.bounds ?? .zero
            let fixedBounds = values.first(where: { $0.viewType == .fixedPositionView })?.bounds ?? .zero
            
            self.offset = movingBounds.minY - fixedBounds.minY
            
            self.rotation = self.headerRotation(self.offset)
            /// 触发刷新
            if !self.refreshing, self.offset > self.threshold, self.preOffset <= self.threshold {
                self.refreshing = true
            }
            
            if self.refreshing {
                if self.preOffset > self.threshold, self.offset <= self.threshold {
                    self.frozen = true
                }
            } else {
                self.frozen = false
            }
            
            self.preOffset = self.offset
        }
    }
    
    func headerRotation(_ scrollOffset: CGFloat) -> Angle {
        if scrollOffset < self.threshold * 0.60 {
            return .degrees(0)
        } else {
            let h = Double(self.threshold)
            let d = Double(scrollOffset)
            let v = max(min(d - (h * 0.6), h * 0.4), 0)
            return .degrees(180 * v / (h * 0.4))
        }
    }
    
    /// 位置固定不变的view
    struct FixedPositionView: View {
        var body: some View {
            GeometryReader { proxy in
                Color
                    .clear
                    .preference(key: MCRefreshablePreferenceTypes.MCRefreshablePreferenceKey.self,
                                value: [MCRefreshablePreferenceTypes.MCRefreshablePreferenceData(viewType: .fixedPositionView, bounds: proxy.frame(in: .global))])
            }
        }
    }
    
    /// 位置随着滑动变化的view，高度为0
    struct MovingPositionView: View {
        var body: some View {
            GeometryReader { proxy in
                Color
                    .clear
                    .preference(key: MCRefreshablePreferenceTypes.MCRefreshablePreferenceKey.self,
                                value: [MCRefreshablePreferenceTypes.MCRefreshablePreferenceData(viewType: .movingPositionView, bounds: proxy.frame(in: .global))])
            }
            .frame(height: 0)
        }
    }
    
    struct RefreshHeader: View {
        var height: CGFloat
        var loading: Bool
        var frozen: Bool
        var rotation: Angle
        var updateTime: Date
        
        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "MM月dd日 HH时mm分ss秒"
            return df
        }()
        
        var body: some View {
            HStack(spacing: 20) {
                Spacer()
                
                Group {
                    if self.loading {
                        VStack {
                            Spacer()
                            ActivityRep()
                            Spacer()
                        }
                    } else {
                        Image(systemName: "arrow.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .rotationEffect(rotation)
                    }
                }
                .frame(width: height * 0.25, height: height * 0.8)
                .fixedSize()
                .offset(y: (loading && frozen) ? 0 : -height)
                
                VStack(spacing: 5) {
                    Text("\(self.loading ? "正在刷新数据" : "下拉刷新数据")")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                    Text("\(self.dateFormatter.string(from: updateTime))")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                .offset(y: -height + (loading && frozen ? +height : 0.0))
                
                Spacer()
            }
            .frame(height: height)
        }
    }
}

struct MCRefreshablePreferenceTypes {
    enum ViewType: Int {
        case fixedPositionView
        case movingPositionView
    }
    
    struct MCRefreshablePreferenceData: Equatable {
        let viewType: ViewType
        let bounds: CGRect
    }
    
    struct MCRefreshablePreferenceKey: PreferenceKey {
        static var defaultValue: [MCRefreshablePreferenceData] = []
        
        static func reduce(value: inout [MCRefreshablePreferenceData],
                           nextValue: () -> [MCRefreshablePreferenceData]) {
            value.append(contentsOf: nextValue())
        }
    }
}

struct ActivityRep: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityRep>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityRep>) {
        uiView.startAnimating()
    }
}
