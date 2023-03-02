//
//  TreeViewModel.swift
//  Tree
//
//  Created by zedsbook on 02.03.2023.
//


import Foundation
import Combine

class TreeViewModel: ObservableObject {
    @Published var rootNode: Node
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "treeData"),
           let decodedData = try? JSONDecoder().decode(Node.self, from: savedData) {
            self.rootNode = decodedData
        } else {
            self.rootNode = Node()
        }
    }
    
    func saveTree() {
        if let encodedData = try? JSONEncoder().encode(rootNode) {
            UserDefaults.standard.set(encodedData, forKey: "treeData")
        }
    }
}
