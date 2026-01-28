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


struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var profileImage: String
}

enum Priority {
    case high, medium,low
}
class Task {
    var name: String
    var priority: Priority?
    init(name: String) {
        self.name = name
    }
}
    
    // MOCK DATA
extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(
//            id: <#UUID#>(),
            title: "Groceries",
            symbolName: "storefront.circle.fill",
            tasks: [
                TaskItem(title: "Buy Apples"),
                TaskItem(title: "Buy Milk")
            ]
        ),
            
        TaskGroup(
//            id: UUID(),
            title: "Home",
            symbolName: "house.fill",
            tasks: [
                TaskItem(title: "Walk the dog", isCompleted: true ),
                TaskItem(title: "Clean the kitchen")
            ]
        )
    ]
}
    
extension Profile {
    static let sample: [Profile] = [
        Profile(id: UUID(), name: "John", profileImage: "profile1"),
        Profile(id: UUID(), name: "Jane", profileImage: "profile2")
    ]
}
