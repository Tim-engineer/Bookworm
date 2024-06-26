//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Tim Matlak on 25/06/2024.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Book.self)
        }
    }
}
