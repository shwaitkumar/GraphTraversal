//
//  ContentView.swift
//  GraphTraversing
//
//  Created by Shwait Kumar on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingDFS = false
    @State private var isShowingBFS = false
    
    var body: some View {
        VStack(spacing: 44) {
            Button(action: {
                isShowingDFS.toggle()
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay {
                        Text("Traverse using DFS")
                            .foregroundStyle(.white)
                    }
            })
            .frame(height: 60)
            .sheet(isPresented: $isShowingDFS) {
                GraphTraversalView(traversalType: "DFS")
                    .presentationCornerRadius(24)
                    .presentationDragIndicator(.visible)
            }
            
            Button(action: {
                isShowingBFS.toggle()
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay {
                        Text("Traverse using BFS")
                            .foregroundStyle(.white)
                    }
            })
            .frame(height: 60)
            .sheet(isPresented: $isShowingBFS) {
                GraphTraversalView(traversalType: "BFS")
                    .presentationCornerRadius(24)
                    .presentationDragIndicator(.visible)
            }
        } //: VSTACK
        .padding()
        .padding(.horizontal)
        .font(.title3)
        .fontWeight(.medium)
    }
}

#Preview {
    ContentView()
}
