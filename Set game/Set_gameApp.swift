//
//  Set_gameApp.swift
//  Set game
//
//  Created by ezz on 02/09/2024.
//

import SwiftUI

@main
struct Set_gameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
