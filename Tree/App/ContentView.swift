//
//  ContentView.swift
//  Tree
//
//  Created by zedsbook on 02.03.2023.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var treeViewModel = TreeViewModel()
    
    var body: some View {
        NavigationView {
            NodeView(node: treeViewModel.rootNode)
                .onDisappear {
                    treeViewModel.saveTree()
                }
        }
    }
}
