//
//  NodeView.swift
//  Tree
//
//  Created by zedsbook on 02.03.2023.
//

import SwiftUI

struct NodeView: View {
    @ObservedObject var node: Node
    
    var body: some View {
        List {
            ForEach(node.children) { child in
                NavigationLink(destination: NodeView(node: child)) {
                    Text(child.name)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    node.removeChild(node.children[index])
                }
            }
        }
        .navigationBarTitle(node.name)
        .navigationBarItems(
            trailing: Button("Add") {
                let _ = node.addChild()
            }
        )
    }
}
