import SwiftUI
import Combine

struct ContentView: View {
    @State private var taskGroups = TaskGroup.sampleData
    @State private var profiles: [Profile] = []
    
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    @State private var path = NavigationPath()
    
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    let saveKey = "savedProfile"
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Select the working profile")
                    .font(.largeTitle.bold())
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(taskGroups) { group in
                        NavigationLink(value: group) {
                            VStack {
                                Image(group.symbolName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(.circle)
                                Text(group.title)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Profile.self) { profile in
                if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
                    DashBoardView(profile: $profiles[index])
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
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
        if let encodedData = try? JSONEncoder().encode(profiles) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedProfiles = try? JSONDecoder().decode([Profile].self, from: savedData) {
                profiles = decodedProfiles
                return
            }
        }
        
        // show mock data for dev purposes
        profiles = Profile.sample
    }
}
