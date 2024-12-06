//
//  GraphTraversalView.swift
//  GraphTraversing
//
//  Created by Shwait Kumar on 06/12/24.
//

import SwiftUI

struct GraphTraversalView: View {
    let traversalType: String
    @State private var numberOfNodes: Int = 5
    @State private var graph: [Int: [Int]] = [:]
    @State private var startNode: Int = 0
    @State private var traversalResult: [Int] = []
    @State private var showResult: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(traversalType) Traversal")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom)
                
                // Input for number of nodes
                HStack {
                    Text("Number of Nodes:")
                        .fontWeight(.semibold)
                    TextField("Enter number", value: $numberOfNodes, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                } //: HSTACK
                .padding()
                
                // Generate Graph Buttons
                VStack(spacing: 10) {
                    Button(action: {
                        graph = generateRandomGraph(nodeCount: numberOfNodes)
                    }) {
                        Text("Generate Random Graph")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } //: VSTACK
                .padding()
                
                // Display Graph
                VStack(alignment: .leading) {
                    Text("Generated Graph:")
                        .font(.headline)
                    ForEach(graph.keys.sorted(), id: \.self) { key in
                        HStack {
                            Text("\(key):")
                                .fontWeight(.bold)
                            Text(graph[key]?.map { String($0) }.joined(separator: ", ") ?? "")
                        } //: HSTACK
                        .padding(.bottom, 2)
                    }
                } //: VSTACK
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                // Input for start node
                HStack {
                    Text("Start Node:")
                        .fontWeight(.semibold)
                    TextField("Enter node", value: $startNode, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                } //: HSTACK
                .padding()
                
                // Traverse Button
                Button(action: {
                    if graph[startNode] == nil {
                        traversalResult = []
                        showResult = true
                    } else {
                        if traversalType == "DFS" {
                            traversalResult = dfs(start: startNode, graph: graph)
                        } else {
                            traversalResult = bfs(start: startNode, graph: graph)
                        }
                        showResult = true
                    }
                }) {
                    Text("Traverse")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.headline)
                }
                .padding()
                
                // Display Result
                if showResult {
                    VStack {
                        if traversalResult.isEmpty {
                            Text("Node \(startNode) does not exist in the graph!")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                        } else {
                            Text("Traversal Result: \(traversalResult.map { String($0) }.joined(separator: " -> "))")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 40) // Extra space after the output
                }
                
                Spacer()
            } //: VSTACK
            .padding()
            .padding(.vertical)
        } //: SCROLLVIEW
        .navigationTitle("\(traversalType) Traversal")
        .padding(.top)
        .onTapGesture {
            dismissKeyboard()
        }
    }
    
    // Helper method to dismiss the keyboard
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // Generate a random graph with a specified number of nodes
    func generateRandomGraph(nodeCount: Int) -> [Int: [Int]] {
        var newGraph: [Int: [Int]] = [:]
        for node in 0..<nodeCount {
            let numberOfEdges = Int.random(in: 1...nodeCount / 2)
            var edges: Set<Int> = []
            while edges.count < numberOfEdges {
                let randomNode = Int.random(in: 0..<nodeCount)
                if randomNode != node { // Avoid self-loops
                    edges.insert(randomNode)
                }
            }
            newGraph[node] = Array(edges)
        }
        return newGraph
    }
    
    // Depth-First Search
    func dfs(start: Int, graph: [Int: [Int]]) -> [Int] {
        var visited = Set<Int>()
        var result = [Int]()
        var stack = [start]
        
        while let node = stack.popLast() {
            if !visited.contains(node) {
                visited.insert(node)
                result.append(node)
                stack.append(contentsOf: graph[node] ?? [])
            }
        }
        return result
    }
    
    // Breadth-First Search
    func bfs(start: Int, graph: [Int: [Int]]) -> [Int] {
        var visited = Set<Int>()
        var result = [Int]()
        var queue = [start]
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if !visited.contains(node) {
                visited.insert(node)
                result.append(node)
                queue.append(contentsOf: graph[node] ?? [])
            }
        }
        return result
    }
}

#Preview {
    GraphTraversalView(traversalType: "DFS")
}
