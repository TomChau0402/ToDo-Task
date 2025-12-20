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
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select the workign profile")
                    .font(.largeTitle.bold())
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach($profiles) {$profile in
                        NavigationLink(value: profile ){
                            VStack {
                                Image(profile.profileImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(.circle)
                                Text(profile.name)
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
        .navigationDestination(for: Profile.self) { profile in
            if let index = profiles.name.firstIndex(where: {$0.id ==
                selectedProfile.id}) {
                DashBoardView(profile: profile[indext])
                    .navigationBarBackButtonHidden(true)
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
        }
    
