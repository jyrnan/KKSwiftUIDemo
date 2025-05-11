//
//  PhaseAnimator.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/1.
//

import SwiftUI

enum PhaseAnimatorState: String, CaseIterable, Identifiable {
    case start
    case progressing
    case end
    
    var id: String {
        self.rawValue
    }
}

struct PhaseAnimatorDemoView: View {
    var body: some View {
        VStack {
            VStack {
//                ForEach(PhaseAnimatorState.allCases) { state in
//                    Text(state.rawValue)
//                        .font(.largeTitle)
//                }
                Color.clear
                .phaseAnimator(PhaseAnimatorState.allCases) { content, phase in
                    switch phase {
                    case .start:
                        phaseContent(phase: phase)
                            .foregroundStyle(.red)
                    case .progressing:
                        phaseContent(phase: phase)
                            .foregroundStyle(.yellow)
                            .transition(.blurReplace(.upUp))
                    case .end:
                        phaseContent(phase: phase)
                            .transition(.push(from: .bottom))
                            
                            .foregroundStyle(.yellow)
                    }
                } animation: { phase in
                        switch phase {
                           case .start:
                                .linear(duration: 1)
                        case .progressing:
                                .linear(duration: 1)
                        case .end:
                            .easeOut(duration: 1)
                        
                        
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func phaseContent(phase: PhaseAnimatorState) -> some View {
        Text(phase.rawValue)
            .font(.title)
    }
        
}

#Preview {
    PhaseAnimatorDemoView()
}
