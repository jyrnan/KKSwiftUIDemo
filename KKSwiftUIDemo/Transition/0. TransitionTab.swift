//
//----------------------------------------------
// Original project: TransitionsAndAnimations
// by  Stewart Lynch on 2025-02-22
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2025 CreaTECH Solutions. All rights reserved.


import SwiftUI

struct TransitionTab: View {
    var body: some View {
        TabView {
            Tab("Simple", systemImage: "1.circle") {
                SimpleTransitionsView()
            }
            Tab("Complex", systemImage: "2.circle") {
                ComplexTransitionsView()
            }
        }
    }
}

extension TreeNode {
    static let transition: TreeNode = .init(name: "transition")
        
}
