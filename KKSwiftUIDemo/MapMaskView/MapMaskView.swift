//
//  MapMaskView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/3.
//

import MapKit
import SwiftUI

struct MapMaskView: View {
    @State private var margin: CGFloat = 0
    @State private var bottomMargin: CGFloat = 0
    @State private var searchText: String = ""
    
    @FocusState private var focused: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Color(uiColor: .secondarySystemBackground)
                VStack(spacing: 0) {
                    Color.clear
                        .frame(height: geometry.size.height / 2)
                }
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.76835683517602, longitude: 113.91741999511295), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))
                    .edgesIgnoringSafeArea(.all)
                    .mask(
                        RoundedRectangle(cornerRadius: 48)
                        
                            .padding([.top, .horizontal], margin)
                            .padding(.bottom, bottomMargin)
                    )
                
                VStack {
                    Color.clear
                        .frame(height: geometry.size.height - bottomMargin - 80)
                            
                        HStack {
                            TextField("Place", text: $searchText)
                                .focused($focused)
                        
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.accentColor)
                        }
                    
                        .padding(4)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
                        .padding(.horizontal, 32)
                        .onChange(of: focused) { _, newValue in
                            withAnimation(.easeInOut(duration: 0.5)) {
                                margin = margin == 0 ? 8 : 0
                                bottomMargin = bottomMargin == 0 ? geometry.size.height / 2 : 0
                            }
                        }
                }
            }
            .ignoresSafeArea()
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MapMaskView()
}
