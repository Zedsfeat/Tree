//
//  Node.swift
//  Tree
//
//  Created by zedsbook on 02.03.2023.
//

import Foundation
import Combine

class Node: Codable, Identifiable, ObservableObject {
    
    static var idToNode: [UUID: Node] = [:]
    
    let id = UUID()
    weak var parent: Node?
    
    @Published var name: String
    @Published var children: [Node] = []
    
    
    init(name: String = "Root", parent: Node? = nil) {
        self.name = UUID().hashValue.description
        self.parent = parent
        Node.idToNode[id] = self
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, children, parent
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.children = try container.decode([Node].self, forKey: .children)
        let parentId = try container.decodeIfPresent(UUID.self, forKey: .parent)
        if let parent = parentId.flatMap({ Node.idToNode[$0] }) {
            self.parent = parent
        }
        Node.idToNode[id] = self
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(children, forKey: .children)
        try container.encode(parent?.id, forKey: .parent)
    }
}


extension Node {
    
    func addChild() -> Node {
        let newChild = Node(parent: self)
        children.append(newChild)
        return newChild
    }
    
    func removeChild(_ child: Node) {
        children.removeAll(where: { $0.id == child.id })
    }
}
