//
//  ShareLinkDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/6/17.
//

import SwiftUI

struct ShareLinkDemo: View {
    var body: some View {
        VStack(spacing: 20) {
            ShareLink(item: "Hello, SwiftUI!") {
                Label("分享文本", systemImage: "text.bubble")
            }
            
            ShareLink(
                item: URL(string: "https://www.apple.com")!,
                subject: Text("推荐网站"),
                message: Text("看看 Apple 的官网！")
            ) {
                Label("分享链接", systemImage: "link")
            }
            
            ShareLink(
                item: Image(systemName: "star.fill"),
                preview: SharePreview(
                    Text("Star Icon"),
                    image: Image(systemName: "star.fill")
                )
            ) {
                Label("分享图片", systemImage: "photo")
            }
        }
    }
}

#Preview {
    ShareLinkDemo()
}
