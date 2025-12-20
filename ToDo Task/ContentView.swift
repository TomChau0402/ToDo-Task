//
//  ContentView.swift
//  ToDo Task
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var profiles: [Profile] = []
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("isDarkMode") private var isDarkMode = false
    let saveKey = "savedProfile"
    @State private var path = NavigationPath()
    let column = Grid
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(taskGroups) {group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("ToDo APP")
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(groups: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active {
                print("🟢 App is Active")
            } else if newValue == .inactive {
                print("🟡 App is Inactive")
            } else if newValue == .background {
                print("🔴 App is Background - Saving Data!")
                saveData()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)

    }
    
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(taskGroups){
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey){
            if let decodedGrpups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodedGrpups
                return
            }
        }
        
        // show mock data for dev purposes
        taskGroups = TaskGroup.sampleData
    }
}
