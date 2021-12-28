//
//  UI_405App.swift
//  UI-405
//
//  Created by nyannyan0328 on 2021/12/28.
//

import SwiftUI
import RealmSwift

@main
struct UI_405App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.realmConfiguration, Realm.Configuration())
            
        }
    }
}
