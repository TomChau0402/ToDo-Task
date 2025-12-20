//
//  DashBoardView.swift
//  ToDo Task
//

import SwiftUI
import Combine

struct DashBoardView: View {
    @Binding var profile: Profile
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedGroup) {
                ForEach(profile.groups) {
                    NavigationLink(value:group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle(placement: .topBarLeading) {
                Button {
                    dismiss() }
                label : {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Home")
                    }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button { isShowingAddGroup = true } label : {
                    Image(systemName: "plus")
                }
            }
        }
    } detail: {
        if let group = selectedGroup {
            if let indext = profile.groups.firstIndex(where: { $0.self == group }) {
                TaskListView(group: $profile.groups[indext])
            }
        } else {
            ContentUnavailable("Select a group to view tasks", systemImage: "sidebar.left")
        }
    } .sheet(isPresent: $isShowingAddGroup) {
        NewGroupView { newGroup in
            profile.group.append(newGroup)}
        
    }
}

