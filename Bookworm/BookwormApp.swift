//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Николай Никитин on 11.10.2022.
//

import SwiftUI

@main
struct BookwormApp: App {

  @StateObject private var dataContorller = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(\.managedObjectContext, dataContorller.container.viewContext)
        }
    }
}
