//
//  TaskModels.swift
//  ToDo Task



import Foundation
import Combine

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}



struct TaskGroup: Identifiable {
    let id: UUID
    var title: String
    var symbolName: String
}

struct Profile: Identifiable, Codable {
    let id: UUID
    var name: String
    var profileImage: String
    
    static var sampleData: [Profile] = [
        Profile(id: UUID(), name: "John", profileImage: "profile1"),
        Profile(id: UUID(), name: "Jane", profileImage: "profile2")
    ]
}
    
    // MOCK DATA
    extension TaskGroup {
        static let sampleData: [TaskGroup] = [
            TaskGroup(title: "Groceries", symbolName: "storefront.circle.fill", tasks: [
                TaskItem(title: "Buy Apples"),
                TaskItem(title: "Buy Milk")
            ]),
            
            TaskGroup(title: "Home", symbolName: "house.fill", tasks: [
                TaskItem(title: "Walk the dog", isCompleted: true ),
                TaskItem(title: "Clean the kitchen")
            ])
        ]
    }
    
    
