//
//  WeekView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/22.
//

import SwiftUI

struct JYWeekView: View {
    @State private var currentWeeks: [Date.Week] = Date().currentWeeks()
    @State private var selectedDate: Date?
    
    @State private var contentPosition: WPScrollPosition = .top
    @State private var scrollOffset: CGFloat = 0
    
    @Namespace private var namespace
    
    @State private var index: Int = 1
    @State private var tabIndex: TabIndex = .middle
    @State private var direction: TabIndex = .middle
    
    var body: some View {
        VStack(spacing: 0) {
//            let currentWeek = currentWeeks[index ?? 1]
            headerView()
                .environment(\.colorScheme, .dark)
            Text("Current Week: \(tabIndex.rawValue)")
                .foregroundStyle(.white)
                
            Text("Selected Date: \(selectedDate?.string("MMM dd, yyyy") ?? "None")")
                .foregroundStyle(.white)
                
            
//            ZStack {
//                let isTop = contentPosition == .top || contentPosition == .topDragging
//                
//                Color(.tertiarySystemBackground)
//                    
//                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30, style: .continuous))
//                    .padding(.horizontal, 8)
//                    .environment(\.colorScheme, .light)
//                    .offset(y: isTop ? -5 : 0)
//                GeometryReader {
//                    let size = $0.size
//                    
//                    
//                    ScrollView(.vertical) {
//                        LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
//                            ForEach(currentWeek.days) { day in
//                                let date = day.date
//                                let isLast = currentWeek.last?.id == day.id
//                                
//                                Section {
//                                    VStack(alignment: .leading, spacing: 15) {
//                                        VStack {
//                                            Text(date.string("EEE"))
//                                                .font(.title.bold())
//                                                .foregroundStyle(.black)
//                                            Text("content")
//                                                .foregroundStyle(.gray)
//                                        }
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: 150 * (Bool.random() ? 1 : 1))
//                                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
//                                    }
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.leading, 70)
//                                    .padding(.top, -70)
//                                    .padding(.bottom, 10)
//                                    /// 70: Negative padding,  40: content padding
////                                    .frame(minHeight: isLast ? size.height - 110 : nil, alignment: .top)
//                                    .border(.red)
//                                    
//                                } header: {
//                                    VStack(spacing: 4) {
//                                        Text(date.string("EEE"))
//                                        Text(date.string("dd"))
//                                            .font(.largeTitle.bold())
//                                    }
//                                    .frame(height: 70)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                }
//                            }
//                        }
//                        .scrollTargetLayout()
//                    }
//                    .contentMargins(.all, 20, for: .scrollContent)
//                    .contentMargins(.vertical, 20, for: .scrollIndicators)
//                    .onScrollGeometryChange(for: WPScrollPosition.self, of: { geo in
//                        let draggingThreadhold: CGFloat = 150
//                        var position = WPScrollPosition.middle
//                        
//                        //                    print("Scroll Geometry: \(geo)")
//                        if geo.contentOffset.y >= (geo.contentSize.height - geo.containerSize.height - geo.contentInsets.top + draggingThreadhold) {
//                            position = .bottomDragging
//                        } else if geo.contentOffset.y >= (geo.contentSize.height - geo.containerSize.height - geo.contentInsets.top) {
//                            position = .bottom
//                        }
//                        if geo.contentOffset.y <= 0 - geo.contentInsets.top - draggingThreadhold {
//                            position = .topDragging
//                        } else if geo.contentOffset.y <= 0 - geo.contentInsets.top {
//                            position = .top
//                        }
//                        return position
//                    }, action: { old, new in
//                        guard old != new else { return }
//                        print("Scroll Position changed from \(old) to \(new)")
//                        contentPosition = new
//                        
//                    })
////                    .scrollPosition(id: .init(get: {
////                        currentWeek.first(where: { $0.date.isSame(selectedDate) })?.id
////                    }, set: { newValue in
////                        selectedDate = currentWeek.first(where: { $0.id == newValue })?.date
////                    }), anchor: .top)
//                    /// 抵消单元格负向偏移的突变效果
//                    .safeAreaPadding(.bottom, 70)
//                    .padding(.bottom, -70)
//                }
//                .background(.background)
//                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30, style: .continuous))
//                .overlay{
//                    UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30, style: .continuous)
//                        .stroke(.gray.opacity(isTop ? 0.3 : 0 ) , lineWidth: 2)
//                        
//                }
//                .environment(\.colorScheme, .light)
//                
//                //            .offset(y: scrollOffset)
//                .ignoresSafeArea(.all, edges: .bottom)
//                
//                Text("Scroll Position: \(contentPosition.rawValue)")
//                    .font(.title)
//                    
//            }
//            .animation(.default, value: contentPosition)
        }
        .background(Color(.darkGray))
        .onAppear {
//            guard index == nil else { return }
//            index = 1
//            guard selectedDate == nil else { return }
//            let currentWeek = currentWeeks[index ?? 1]
//            selectedDate = currentWeek.first(where: { $0.date.isSame(.now) })?.date
            
        }
        .onChange(of: tabIndex) { oldValue, newValue in
            switch newValue {
            case .preious:
                direction = .preious
                
            case .next:
                direction = .next
                
            case .middle:
                break
            }
        }
        
    }

    
    @ViewBuilder
    func headerView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("This Week")
                    .font(.title.bold())
                    .fontWeight(.semibold)
                
                Spacer(minLength: 0)
                
                Button {} label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(.circle)
                }
            }
            
            /// Week View
//            ScrollView(.horizontal, showsIndicators: false) {
                TabView(selection: $tabIndex) {
                    ForEach(TabIndex.allCases, id:\.rawValue) { position in
                        let week = currentWeeks[position.rawValue]
                        HStack(spacing: 0) {
                            ForEach(week.days) { day in
                                let date = day.date
                                let isSameDate = date.isSame(selectedDate)
                                
                                VStack(spacing: 0) {
                                    Text(date.string("EEE"))
                                        .font(.caption)
                                    
                                    Text(date.string("dd"))
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(isSameDate ? .black : .white)
                                        .frame(width: 38, height: 38)
                                        .background {
                                            if isSameDate {
                                                Circle()
                                                    .fill(.white)
                                                    .matchedGeometryEffect(id: "ACTIVEDATE", in: namespace)
                                            }
                                        }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                        selectedDate = date
                                    }
                                }
                            }
                        }
                        .animation(.snappy(duration: 0.25, extraBounce: 0), value: selectedDate)
                        .frame(height: 80)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .offset(y: 5)
                        .tag(position)
                        .onDisappear {
//                            guard tabIndex == .middle, position != .middle else { return }
                            switch direction {
                            case .preious:
                                currentWeeks = [Date().preWeek(of: currentWeeks[0]), currentWeeks[0], currentWeeks[1]]
                            case .next:
                                currentWeeks = [(currentWeeks[1]), currentWeeks[2], Date().nextWeek(of: currentWeeks[2])]
                            default:
                                    break
                            }
                            direction = .middle
                            tabIndex = .middle
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
//                .scrollTargetLayout()
//            }
//            .scrollTargetBehavior(.viewAligned)
//            .scrollPosition(id: .init(get: {
//                currentWeeks[index ?? 1].id
//            }, set: { id in
//                index = currentWeeks.firstIndex(where: { $0.id == id }) ?? 1
//            }), anchor: .center)
//            .onScrollGeometryChange(for:Edge.self) { geo in
////                print("Scroll Geometry: \(geo)")
//                let offsetX = geo.contentOffset.x
//                let contentWidth = geo.contentSize.width
//                if offsetX <= contentWidth / 4 {return .leading}
////                if offsetX == 371 {return .top}
//                if offsetX >= contentWidth * 3 / 4 {return .trailing}
//                return .top
//                    
//                
//            } action: { oldValue, newValue in
//                print("Scroll Edge changed from \(oldValue) to \(newValue)")
//                guard oldValue == .top else { return }
//                guard newValue != .top else { return }
//                switch newValue {
//                case .leading:
//                    print("Scroll Edge: Leading")
//                case .trailing:
//                    print("Scroll Edge: Trailing")
//                default:
//                    break
//                }
//            }
            
            HStack {
                Text(selectedDate?.string("MMM") ?? "")
                    
                Spacer()
                
                Text(selectedDate?.string("YYYY") ?? "")
            }
            .font(.caption2)
        }
        .padding([.horizontal, .top], 15)
        .padding(.bottom, 10)
    }
    
    func update() {
//        guard oldValue == 1 else {return}
//        guard newValue != 1 else {return}
//        if newValue > oldValue {
//            
//            print("Index changed from \(oldValue ) to \(newValue)")
//            guard let lastWeek = currentWeeks.last else { return }
//            let newLastWeek = Date().nextWeek(of: lastWeek)
//            currentWeeks = [currentWeeks[1], currentWeeks[2], newLastWeek]
//            
//        } else {
//            print("Index changed from \(oldValue ) to \(newValue)")
//            guard let preWeek = currentWeeks.first else { return }
//            let newPreWeek = Date().nextWeek(of: preWeek)
//            currentWeeks = [newPreWeek, currentWeeks[0], currentWeeks[1]]
//        
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//            
//            index = 1
//        }
    }
}

#Preview {
    JYWeekView()
        .environment(\.locale, .init(identifier: "zh_CN"))
}

enum WPScrollPosition: String, CaseIterable, Sendable {
    case topDragging
    case top
    case middle
    case bottom
    case bottomDragging
}

enum TabIndex: Int, CaseIterable {
    case preious = 0
    case middle = 1
    case next = 2
}
