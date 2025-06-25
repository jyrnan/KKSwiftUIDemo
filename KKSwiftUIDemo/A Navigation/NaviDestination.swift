//
//  NaviDestination.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/31.
//

// updae for xcode cloud
import SwiftUI

enum NaviDestination: String, CaseIterable, View, Identifiable {
    var id: String { self.rawValue }

    case appState
    case containerValues
    case Debounce
    
    case transition
    case ContentTransition
    case KeyFrameAnimator
    case ShakeEffect
    case PhaseAnimator

    case complexScrollAnimation
    case onScrollGeometryChange
    case ScrollTargetBehavior

    case RestrictedTextField
    case StringFormat
    
    case FullScreenCover
    case MapMask
    case position
    case splitView
    case ShareLink
    
    case WeekCalendar
    case GestureRecognition
    case CardFlipAnimation

    var body: some View {
        switch self {
        case .appState:
            AppStateView()
        case .containerValues:
            CustomList {
                Text("Hello, World!")
                    .isHighlied(true)
            }
        case .Debounce:
            DebounceSearchView()
            
        case .transition:
            TransitionTab()
        case .ContentTransition:
            ContentTransitionDemo()
        case .KeyFrameAnimator:
            KeyFrame()
        case .ShakeEffect:
            ShakeEffectDemo()
            case .PhaseAnimator:
            PhaseAnimatorDemoView()
            
        
        case .complexScrollAnimation:
            ComplexScrollAnimation()
        case .onScrollGeometryChange:
            OnScrollGeometryChangeDemo()
        case .ScrollTargetBehavior:
            ScrollTargetBehaviorDemo()
            
        case .RestrictedTextField:
            RestrictedTextFieldWrapper()
            case .StringFormat:
            StringFormatDemo()
            
        case .FullScreenCover:
            FullScreenCoverView()
        case .MapMask:
            MapMaskView()
            case .position:
            PositionViewDemo()
        case .splitView:
            Splitview()
        case .ShareLink:
            ShareLinkDemo()
            
        case .WeekCalendar:
            JYWeekView().environment(\.locale, .init(identifier: "zh_CN"))
        case .GestureRecognition:
            GestureRecognitionDemo()
        case .CardFlipAnimation:
            CardFlipAnimationDemo()
        }
    }
}
