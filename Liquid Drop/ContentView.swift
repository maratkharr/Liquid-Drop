//
//  ContentView.swift
//  Liquid Drop
//
//  Created by Marat Kharrasov on 23.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = CGPoint(x: 0, y: 0)
    @State private var delta = false
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                ZStack {
                    Circle()
                        .frame(width: delta ? 120 : 100)
                        .foregroundColor(.white)
                        .blur(radius: 20)
                    Circle()
                        .frame(width: delta ? 120 : 100)
                        .foregroundColor(delta ? .white : .white)
                        .offset(x: offset.x, y: offset.y)
                        .blur(radius: 20)
                        .animation(.default)
                }
                .frame(maxWidth: geometry.size.width+200, maxHeight: geometry.size.height+200)
                .drawingGroup()
                .overlay(
                    Color(white: 0.25)
                        .blendMode(.colorBurn)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
                .overlay(
                    Color(white: 1.0)
                        .blendMode(.colorDodge)
                        .frame(maxWidth: geometry.size.width+200, maxHeight: geometry.size.height+200)
                )
                .overlay(
                    RadialGradient(colors: [Color.yellow, (delta ? Color.red : Color.yellow)], center: .center, startRadius: 64, endRadius: 65)
                        .blur(radius: 10)
                        .blendMode(.plusDarker)
                        .frame(maxWidth: geometry.size.width+200, maxHeight: geometry.size.height+200)
                )
                .frame(width: .infinity, height: .infinity)
                Image(systemName: "cloud.sun.rain.fill")
                    .font(.system(size: 32))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
                    .offset(x: offset.x, y: offset.y)
                    .animation(.default)
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset.x = gesture.location.x - geometry.size.width/2
                        offset.y = gesture.location.y - geometry.size.height/2
                        if offset.y > 64 || offset.y < -64 || offset.x > 64 || offset.x < -64 {
                            withAnimation {
                                delta = true
                            }
                        } else {
                            withAnimation {
                                delta = false
                            }
                        }
                    }
                    .onEnded({ _ in
                        withAnimation {
                            offset = CGPoint(x: 0, y: 0)
                            delta = false
                        }
                    })
                )
        })
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
