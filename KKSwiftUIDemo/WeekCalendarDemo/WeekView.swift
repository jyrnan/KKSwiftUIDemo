//
//  WeekView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/22.
//

import SwiftUI

struct WeekView: View {
    @State private var currentWeek: [Date.Day] = Date.currentWeek
    @State private var selectedDate: Date?
    
    @State private var contentPosition: WPScrollPosition = .top
    @State private var scrollOffset: CGFloat = 0
    
    @Namespace private var namespace
    
    var body: some View {
        VStack(spacing: 0) {
            headerView()
                .environment(\.colorScheme, .dark)
            
            ZStack {
                let isTop = contentPosition == .top || contentPosition == .topDragging
                
                Color(.tertiarySystemBackground)
                    
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30, style: .continuous))
                    .padding(.horizontal, 8)
                    .environment(\.colorScheme, .light)
                    .offset(y: isTop ? -5 : 0)
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                            ForEach(currentWeek) { day in
                                let date = day.date
                                let isLast = currentWeek.last?.id == day.id
                                
                                Section {
                                    VStack(alignment: .leading, spacing: 15) {
                                        VStack {
                                            Text(date.string("EEE"))
                                                .font(.title.bold())
                                                .foregroundStyle(.black)
                                            Text("content")
                                                .foregroundStyle(.gray)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 150 * (Bool.random() ? 1 : 1))
                                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.leading, 70)
                                    .padding(.top, -70)
                                    .padding(.bottom, 10)
                                    /// 70: Negative padding,  40: content padding
//                                    .frame(minHeight: isLast ? size.height - 110 : nil, alignment: .top)
                                    .border(.red)
                                    
                                } header: {
                                    VStack(spacing: 4) {
                                        Text(date.string("EEE"))
                                        Text(date.string("dd"))
                                            .font(.largeTitle.bold())
                                    }
                                    .frame(height: 70)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .contentMargins(.all, 20, for: .scrollContent)
                    .contentMargins(.vertical, 20, for: .scrollIndicators)
                    .onScrollGeometryChange(for: WPScrollPosition.self, of: { geo in
                        let draggingThreadhold: CGFloat = 150
                        var position = WPScrollPosition.middle
                        
                        //                    print("Scroll Geometry: \(geo)")
                        if geo.contentOffset.y >= (geo.contentSize.height - geo.containerSize.height - geo.contentInsets.top + draggingThreadhold) {
                            position = .bottomDragging
                        } else if geo.contentOffset.y >= (geo.contentSize.height - geo.containerSize.height - geo.contentInsets.top) {
                            position = .bottom
                        }
                        if geo.contentOffset.y <= 0 - geo.contentInsets.top - draggingThreadhold {
                            position = .topDragging
                        } else if geo.contentOffset.y <= 0 - geo.contentInsets.top {
                            position = .top
                        }
                        return position
                    }, action: { old, new in
                        guard old != new else { return }
                        print("Scroll Position changed from \(old) to \(new)")
                        contentPosition = new
                        
                    })
                    .scrollPosition(id: .init(get: {
                        currentWeek.first(where: { $0.date.isSame(selectedDate) })?.id
                    }, set: { newValue in
                        selectedDate = currentWeek.first(where: { $0.id == newValue })?.date
                    }), anchor: .top)
                    /// 抵消单元格负向偏移的突变效果
                    .safeAreaPadding(.bottom, 70)
                    .padding(.bottom, -70)
                }
                .background(.background)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30, style: .continuous))
                .overlay{
                    UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30, style: .continuous)
                        .stroke(.gray.opacity(isTop ? 0.3 : 0 ) , lineWidth: 2)
                        
                }
                .environment(\.colorScheme, .light)
                
                //            .offset(y: scrollOffset)
                .ignoresSafeArea(.all, edges: .bottom)
                
                Text("Scroll Position: \(contentPosition.rawValue)")
                    .font(.title)
                    
            }
            .animation(.default, value: contentPosition)
        }
        .background(Color(.darkGray))
        .onAppear {
            guard selectedDate == nil else { return }
            selectedDate = currentWeek.first(where: { $0.date.isSame(.now) })?.date
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
            HStack(spacing: 0) {
                ForEach(currentWeek) { day in
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
            .padding(.vertical, 5)
            .offset(y: 5)
            
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
}

#Preview {
    WeekView()
        .environment(\.locale, .init(identifier: "zh_CN"))
}

enum WPScrollPosition: String, CaseIterable, Sendable {
    case topDragging
    case top
    case middle
    case bottom
    case bottomDragging
}
